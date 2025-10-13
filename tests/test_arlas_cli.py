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

def test_create_configuration(configuration_parameters):
    """Test creating a new configuration."""
    result = run_cli_command(configuration_parameters)
    assert "tests" in result.stdout, result.stderr

def test_set_default_configuration():
    """Test setting the default configuration."""
    result = run_cli_command(["confs", "set", "tests"])
    assert result.returncode == 0
    result = run_cli_command(["confs", "default"])
    assert "tests" in result.stdout, result.stderr

def test_check_configuration():
    """Test checking the configuration."""
    result = run_cli_command(["confs", "check", "tests"])
    assert "ARLAS Server: ...  ok" in result.stdout, result.stderr
    assert "ARLAS Persistence: ...  ok" in result.stdout, result.stderr
    assert "ARLAS IAM: ...  ok" in result.stdout, result.stderr
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
        "indices", "--config", "tests", "mapping", "tests/data/test_data.ndjson",
        "--nb-lines", "5",
        "--push-on", "org.com@sample_test"
    ])
    assert result.returncode == 0
    result = run_cli_command(["indices", "--config", "tests", "list"])
    assert "org.com@sample_test" in result.stdout, result.stderr

def test_describe_mapping():
    """Test describing the mapping from Elasticsearch."""
    result = run_cli_command(["indices", "--config", "tests", "describe", "org.com@sample_test"])
    assert "point_geometry_wkt" in result.stdout
    assert "name" in result.stdout

def test_add_data():
    """Test adding data to Elasticsearch."""
    result = run_cli_command([
        "indices", "--config", "tests", "data", "org.com@sample_test",
        "tests/data/test_data.ndjson"
    ])
    assert result.returncode == 0, result.stderr
    time.sleep(2)  # Wait for data to be indexed
    result = run_cli_command(["indices", "--config", "tests", "list"])
    assert "org.com@sample_test" in result.stdout and "| 5" in result.stdout, result.stderr

def test_clone_index():
    """Test cloning an index."""
    run_cli_command(["indices", "--config", "tests", "clone", "org.com@sample_test", "org.com@sample_test2"])
    result = run_cli_command(["indices", "--config", "tests", "list"])
    assert "org.com@sample_test2" in result.stdout, result.stderr
    # Clean up
    run_cli_command(["indices", "--config", "tests", "delete", "org.com@sample_test2"], input_data="yes\n")

def test_add_collection():
    """Test adding a collection."""
    result = run_cli_command([
        "collections", "--config", "tests", "create", "sample_test_collection",
        "--index", "org.com@sample_test",
        "--display-name", "Sample Test Collection",
        "--id-path", "id",
        "--centroid-path", "point_geometry",
        "--geometry-path", "polygon_geometry",
        "--date-path", "timestamp",
    ])
    assert result.returncode == 0, result.stderr
    time.sleep(2)
    result = run_cli_command(["collections", "--config", "tests", "list"])
    assert "sample_test_collection" in result.stdout, result.stderr

def test_set_field_alias():
    """Test setting a field alias."""
    result = run_cli_command([
        "collections", "--config", "tests", "set_alias", "sample_test_collection",
        "track.visibility.proportion", "Proportion",
    ])
    assert "Proportion" in result.stdout, result.stderr

def test_set_collection_name():
    """Test setting a collection name."""
    result = run_cli_command([
        "collections", "--config", "tests", "name", "sample_test_collection", "Pretty Sample Collection",
    ])
    assert "Pretty Sample Collection" in result.stdout, result.stderr

def test_describe_collection():
    """Test describing a collection."""
    result = run_cli_command(["collections", "--config", "tests", "describe", "sample_test_collection"])
    assert result.returncode == 0, result.stderr

def test_count_collection():
    """Test counting a collection."""
    result = run_cli_command(["collections", "--config", "tests", "count", "sample_test_collection"])
    assert result.returncode == 0, result.stderr

def test_delete_collection():
    """Test deleting a collection."""
    result = run_cli_command(["collections", "--config", "tests", "delete", "sample_test_collection"], input_data="yes\n")
    assert result.returncode == 0, result.stderr
    time.sleep(2)
    result = run_cli_command(["collections", "--config", "tests", "list"])
    assert "sample_test_collection" not in result.stdout, result.stderr

def test_delete_index():
    """Test deleting an index."""
    result = run_cli_command(["indices", "--config", "tests", "delete", "org.com@sample_test"], input_data="yes\n")
    assert result.returncode == 0, result.stderr
    time.sleep(2)
    result = run_cli_command(["indices", "--config", "tests", "list"])
    assert "org.com@sample_test" not in result.stdout, result.stderr
    result = run_cli_command(["indices", "--config", "tests", "delete", "direct_mapping_index"], input_data="yes\n")
    assert result.returncode == 0, result.stderr

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
    run_cli_command(["confs", "delete", "cloud.arlas.io.support"], input_data="yes\n")
