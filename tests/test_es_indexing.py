import time

from tests.conftest import run_cli_command, check_inferred_types


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


def test_infer_data_json(expected_mapping):
    """Test inferring a mapping on Elasticsearch."""
    result = run_cli_command([
        "indices", "--config", "tests", "mapping", "tests/data/test_data.ndjson",
        "--nb-lines", "5"
    ])
    expected_mapping.append(("nested_field.attribute1", "keyword"))
    expected_mapping.append(("nested_field.attribute2", "long"))
    check_inferred_types(result_output=result.stdout, expected_mapping=expected_mapping, test_name="ndjson data")


def test_infer_data_csv(expected_mapping):
    """Test inferring a mapping on Elasticsearch."""
    result = run_cli_command([
        "indices", "--config", "tests", "mapping", "tests/data/test_data.csv",
        "--nb-lines", "5"
    ])
    check_inferred_types(result_output=result.stdout, expected_mapping=expected_mapping, test_name="csv data")


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

def test_delete_index():
    """Test deleting an index."""
    result = run_cli_command(["indices", "--config", "tests", "delete", "courses"], input_data="yes\n")
    assert result.returncode == 0
    time.sleep(2)
    result = run_cli_command(["indices", "--config", "tests", "list"])
    assert "courses" not in result.stdout
