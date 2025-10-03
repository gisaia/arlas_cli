import time

from tests.conftest import run_cli_command


# --- Tests ---

def test_configuration_login():
    """Test adding a configuration with login."""
    run_cli_command([
        "confs", "login", "support@gisaia.com", "support@gisaia.com", "https://some_elastic_search_server",
        "--auth-password", "toto",
        "--elastic-password", "titi",
    ])
    result = run_cli_command(["confs", "list"])
    assert "cloud.arlas.io.support" in result.stdout
    # Check that the first created conf is set as default
    result = run_cli_command(["confs", "default"])
    assert "cloud.arlas.io.support" in result.stdout, result.stderr

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
    assert "tests" in result.stdout, result.stderr

def test_set_default_configuration():
    """Test setting the default configuration."""
    run_cli_command(["confs", "set", "tests"])
    result = run_cli_command(["confs", "default"])
    assert "tests" in result.stdout, result.stderr

def test_check_configuration():
    """Test checking the configuration."""
    result = run_cli_command(["confs", "check", "tests"])
    assert "ARLAS Server: ...  ok" in result.stdout, result.stderr
    assert "ARLAS Persistence: ...  ok" in result.stdout, result.stderr
    assert "ARLAS IAM: ...  not ok" in result.stdout, result.stderr
    assert "Elasticsearch: ...  ok" in result.stdout, result.stderr

def test_add_and_retrieve_direct_mapping():
    """Test adding a direct mapping on Elasticsearch."""
    run_cli_command([
        "indices", "--config", "tests", "create", "direct_mapping_index",
        "--mapping", "tests/mapping.json",
    ])
    result = run_cli_command(["indices", "--config", "tests", "list"])
    assert "direct_mapping_index" in result.stdout, result.stderr

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
    assert "courses" in result.stdout, result.stderr

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
    assert result.returncode == 0, result.stderr
    time.sleep(2)  # Wait for data to be indexed
    result = run_cli_command(["indices", "--config", "tests", "list"])
    assert "courses" in result.stdout and "200" in result.stdout, result.stderr

def test_clone_index():
    """Test cloning an index."""
    run_cli_command(["indices", "--config", "tests", "clone", "courses", "courses2"])
    result = run_cli_command(["indices", "--config", "tests", "list"])
    assert "courses2" in result.stdout, result.stderr
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
    assert result.returncode == 0, result.stderr
    time.sleep(2)
    result = run_cli_command(["collections", "--config", "tests", "list"])
    assert "courses" in result.stdout, result.stderr

def test_set_field_alias():
    """Test setting a field alias."""
    result = run_cli_command([
        "collections", "--config", "tests", "set_alias", "courses",
        "track.visibility.proportion", "Proportion",
    ])
    assert "Proportion" in result.stdout, result.stderr

def test_set_collection_name():
    """Test setting a collection name."""
    result = run_cli_command([
        "collections", "--config", "tests", "name", "courses", "thecourses",
    ])
    assert "thecourses" in result.stdout, result.stderr

def test_describe_collection():
    """Test describing a collection."""
    result = run_cli_command(["collections", "--config", "tests", "describe", "courses"])
    assert result.returncode == 0, result.stderr

def test_count_collection():
    """Test counting a collection."""
    result = run_cli_command(["collections", "--config", "tests", "count", "courses"])
    assert result.returncode == 0, result.stderr

def test_delete_collection():
    """Test deleting a collection."""
    result = run_cli_command(["collections", "--config", "tests", "delete", "courses"], input_data="yes\n")
    assert result.returncode == 0, result.stderr
    time.sleep(2)
    result = run_cli_command(["collections", "--config", "tests", "list"])
    assert "courses" not in result.stdout, result.stderr

def test_delete_index():
    """Test deleting an index."""
    result = run_cli_command(["indices", "--config", "tests", "delete", "courses"], input_data="yes\n")
    assert result.returncode == 0, result.stderr
    time.sleep(2)
    result = run_cli_command(["indices", "--config", "tests", "list"])
    assert "courses" not in result.stdout, result.stderr

def test_list_configurations():
    """Test listing configurations."""
    result = run_cli_command(["confs", "list"])
    assert "tests" in result.stdout, result.stderr

def test_create_and_delete_configuration():
    """Test creating and deleting a configuration."""
    result = run_cli_command(["confs", "create", "toto", "--server", "http://localhost:9999"])
    assert result.returncode == 0, result.stderr
    result = run_cli_command(["confs", "list"])
    assert "toto" in result.stdout, result.stderr
    result = run_cli_command(["confs", "delete", "toto"])
    assert result.returncode == 0, result.stderr
    result = run_cli_command(["confs", "list"])
    assert "toto" not in result.stdout, result.stderr

def test_persist_add_and_get():
    """Test adding and retrieving a persisted entry."""
    result = run_cli_command([
        "persist", "--config", "tests", "add", "README.md", "my_zone", "--name", "toto",
    ])
    entry_id = result.stdout.strip()
    result = run_cli_command(["persist", "--config", "tests", "zone", "my_zone"])
    assert "toto" in result.stdout, result.stderr
    result = run_cli_command(["persist", "--config", "tests", "get", entry_id])
    # Test entry content
    with open("README.md", "r") as f:
        assert f.read() == result.stdout, result.stderr
    result = run_cli_command(["persist", "--config", "tests", "describe", entry_id])
    assert "toto" in result.stdout, result.stderr

def test_persist_groups():
    """Test listing groups for a persisted entry."""
    result = run_cli_command(["persist", "--config", "tests", "groups", "my_zone"])
    assert "group/public" in result.stdout, result.stderr

def test_delete_configuration():
    """ Test deleting a configuration """
    # Invalid deletion
    result = run_cli_command(["confs", "delete", "tests"], input_data="no\n")
    assert result.returncode == 1, result.stdout
    # Valid deletion
    result = run_cli_command(["confs", "delete", "tests"], input_data="yes\n")
    assert result.returncode == 0, result.stderr
    # Check that 'tests' in no longer listed
    result = run_cli_command(["confs", "list"])
    assert "tests" not in result.stdout, result.stderr
    # Check that 'test' is no longer the default configuration
    result = run_cli_command(["confs", "default"])
    assert "tests" not in result.stdout, result.stderr
