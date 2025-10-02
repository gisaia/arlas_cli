import shutil
import subprocess
import pytest
import os
import time

# Fixture to clean up before and after tests
@pytest.fixture(autouse=True, scope="module")
def cleanup():
    # Remove config file and persistence directory before tests
    config_file = "/tmp/arlas_cli.yaml"
    persist_dir = "/tmp/arlas_cli_persist"
    if os.path.exists(config_file):
        os.remove(config_file)
    if os.path.exists(persist_dir):
        shutil.rmtree(persist_dir)
    run_cli_command(["--version"])
    yield
    # Remove config file and persistence directory after tests
    if os.path.exists(config_file):
        os.remove(config_file)
    if os.path.exists(persist_dir):
        shutil.rmtree(persist_dir)

# Helper function to run CLI commands
def run_cli_command(args, input_data=None):
    cmd = ["python3.10", "-m", "arlas.cli.cli", "--config-file", "/tmp/arlas_cli.yaml"] + args
    result = subprocess.run(
        cmd,
        capture_output=True,
        text=True,
        input=input_data,
    )
    return result

# --- Tests ---

def test_create_configuration():
    """Test creating a new configuration."""
    result = run_cli_command([
        "confs", "create", "tests",
        "--server", "http://localhost:9999/arlas",
        "--persistence", "http://localhost:9997/arlas_persistence_server",
        "--headers", "Content-Type:application/json",
        "--elastic", "http://localhost:9200",
        "--elastic-headers", "Content-Type:application/json",
        "--allow-delete",
    ])
    assert "tests" in result.stdout

def test_configuration_login():
    """Test adding a configuration with login."""
    run_cli_command([
        "confs", "login", "support@gisaia.com", "support@gisaia.com", "https://some_elastic_search_server",
        "--auth-password", "toto",
        "--elastic-password", "titi",
    ])
    result = run_cli_command(["confs", "list"])
    assert "cloud.arlas.io.support" in result.stdout

def test_config_file_exists():
    """Test if the config file exists."""
    assert os.path.exists("/tmp/arlas_cli.yaml")

def test_set_default_configuration():
    """Test setting the default configuration."""
    run_cli_command(["confs", "set", "tests"])
    result = run_cli_command(["confs", "default"])
    assert "Default configuration is tests" in result.stdout

def test_check_configuration():
    """Test checking the configuration."""
    result = run_cli_command(["confs", "check", "tests"])
    assert "ARLAS Server: ...  ok" in result.stdout
    assert "ARLAS Persistence: ...  ok" in result.stdout
    assert "ARLAS IAM: ...  not ok" in result.stdout
    assert "Elasticsearch: ...  ok" in result.stdout

def test_add_and_retrieve_direct_mapping():
    """Test adding a direct mapping on Elasticsearch."""
    run_cli_command([
        "indices", "--config", "tests", "create", "direct_mapping_index",
        "--mapping", "tests/mapping.json",
    ])
    result = run_cli_command(["indices", "--config", "tests", "list"])
    assert "direct_mapping_index" in result.stdout

def test_infer_and_add_mapping():
    """Test inferring and adding a mapping on Elasticsearch."""
    result = run_cli_command([
        "indices", "--config", "tests", "mapping", "tests/sample.json",
        "--nb-lines", "200",
        "--field-mapping", "track.timestamps.center:date-epoch_second",
        "--field-mapping", "track.timestamps.start:date-epoch_second",
        "--field-mapping", "track.timestamps.end:date-epoch_second",
        "--no-fulltext", "cargo_type",
        "--push-on", "courses",
    ])
    assert result.returncode == 0
    result = run_cli_command(["indices", "--config", "tests", "list"])
    assert "courses" in result.stdout

def test_describe_mapping():
    """Test describing the mapping from Elasticsearch."""
    result = run_cli_command(["indices", "--config", "tests", "describe", "courses"])
    assert "track.timestamps.center" in result.stdout
    assert "date" in result.stdout

def test_add_data():
    """Test adding data to Elasticsearch."""
    result = run_cli_command([
        "indices", "--config", "tests", "data", "courses",
        "tests/sample.json", "tests/sample.json",
    ])
    assert result.returncode == 0
    time.sleep(2)  # Wait for data to be indexed
    result = run_cli_command(["indices", "--config", "tests", "list"])
    assert "courses" in result.stdout and "200" in result.stdout

def test_clone_index():
    """Test cloning an index."""
    run_cli_command(["indices", "--config", "tests", "clone", "courses", "courses2"])
    result = run_cli_command(["indices", "--config", "tests", "list"])
    assert "courses2" in result.stdout
    # Clean up
    run_cli_command(["indices", "--config", "tests", "delete", "courses2"], input_data="yes\n")

def test_add_collection():
    """Test adding a collection."""
    result = run_cli_command([
        "collections", "--config", "tests", "create", "courses",
        "--index", "courses",
        "--display-name", "courses",
        "--id-path", "track.id",
        "--centroid-path", "track.location",
        "--geometry-path", "track.trail",
        "--date-path", "track.timestamps.center",
    ])
    assert result.returncode == 0
    time.sleep(2)
    result = run_cli_command(["collections", "--config", "tests", "list"])
    assert "courses" in result.stdout

def test_set_field_alias():
    """Test setting a field alias."""
    result = run_cli_command([
        "collections", "--config", "tests", "set_alias", "courses",
        "track.visibility.proportion", "Proportion",
    ])
    assert "Proportion" in result.stdout

def test_set_collection_name():
    """Test setting a collection name."""
    result = run_cli_command([
        "collections", "--config", "tests", "name", "courses", "thecourses",
    ])
    assert "thecourses" in result.stdout

def test_describe_collection():
    """Test describing a collection."""
    result = run_cli_command(["collections", "--config", "tests", "describe", "courses"])
    assert result.returncode == 0

def test_count_collection():
    """Test counting a collection."""
    result = run_cli_command(["collections", "--config", "tests", "count", "courses"])
    assert result.returncode == 0

def test_delete_collection():
    """Test deleting a collection."""
    result = run_cli_command(["collections", "--config", "tests", "delete", "courses"], input_data="yes\n")
    assert result.returncode == 0
    time.sleep(2)
    result = run_cli_command(["collections", "--config", "tests", "list"])
    assert "courses" not in result.stdout

def test_delete_index():
    """Test deleting an index."""
    result = run_cli_command(["indices", "--config", "tests", "delete", "courses"], input_data="yes\n")
    assert result.returncode == 0
    time.sleep(2)
    result = run_cli_command(["indices", "--config", "tests", "list"])
    assert "courses" not in result.stdout

def test_list_configurations():
    """Test listing configurations."""
    result = run_cli_command(["confs", "list"])
    assert "tests" in result.stdout

def test_create_and_delete_configuration():
    """Test creating and deleting a configuration."""
    result = run_cli_command(["confs", "create", "toto", "--server", "http://localhost:9999"])
    assert result.returncode == 0
    result = run_cli_command(["confs", "list"])
    assert "toto" in result.stdout
    result = run_cli_command(["confs", "delete", "toto"])
    assert result.returncode == 0
    result = run_cli_command(["confs", "list"])
    assert "toto" not in result.stdout

def test_persist_add_and_get():
    """Test adding and retrieving a persisted entry."""
    result = run_cli_command([
        "persist", "--config", "tests", "add", "README.md", "my_zone", "--name", "toto",
    ])
    entry_id = result.stdout.strip()
    result = run_cli_command(["persist", "--config", "tests", "zone", "my_zone"])
    assert "toto" in result.stdout
    result = run_cli_command(["persist", "--config", "tests", "get", entry_id])
    # Test entry content
    with open("README.md", "r") as f:
        assert f.read() == result.stdout
    result = run_cli_command(["persist", "--config", "tests", "describe", entry_id])
    assert "toto" in result.stdout

def test_persist_groups():
    """Test listing groups for a persisted entry."""
    result = run_cli_command(["persist", "--config", "tests", "groups", "my_zone"])
    assert "group/public" in result.stdout
