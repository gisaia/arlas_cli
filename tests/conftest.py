import re
import subprocess
from pathlib import Path
from typing import List, Tuple

import pytest


# module-level context set by the autouse config_file_tests fixture
config_file_path: Path = None

@pytest.fixture(scope="module", autouse=True)
def config_file_tests(tmp_path_factory):
    """Provide a temporary configuration file (auto-used in all tests)."""
    global config_file_path
    config_file_path = tmp_path_factory.mktemp("arlas_cli") / "arlas_cli.yaml"

    yield config_file_path

# Helper function to run CLI commands
def run_cli_command(args, input_data=None):
    cmd = ["python3.10", "-m", "arlas.cli.cli", "--config-file", str(config_file_path)] + args
    result = subprocess.run(
        cmd,
        capture_output=True,
        text=True,
        input=input_data
    )
    return result

@pytest.fixture
def expected_mapping() -> List[Tuple[str, str]]:
    """Load the reference expected fields type for test_data"""
    return [
        ('id', 'long'),
        ('name', 'keyword'),
        ('population', 'long'),
        ('point_geometry', 'geo_point'),
        ('point_geometry_wkt', 'geo_point'),
        ('polygon_geometry', 'geo_shape'),
        ('polygon_geometry_wkt', 'geo_shape'),
        ('mixed_geometry', 'geo_shape'),
        ('mixed_geometry_wkt', 'geo_shape'),
        ('timestamp', 'date'),
        ('tags', 'keyword'),
        ('rating', 'double')
    ]

@pytest.fixture
def configuration_parameters() -> list:
    return [
        "confs", "create", "tests",
        "--server", "https://localhost/arlas",
        "--headers", "Content-Type:application/json",
        "--persistence", "https://localhost/persist",
        "--persistence-headers", "Content-Type:application/json",
        "--elastic", "https://localhost:9200",
        "--elastic-login", "elastic",
        "--elastic-password", "elastic",
        "--elastic-headers", "Content-Type:application/json",
        "--allow-delete",
        "--auth-token-url", "https://localhost/arlas_iam_server/session",
        "--auth-headers", "Content-Type:application/json",
        "--auth-login", "user@org.com",
        "--auth-password", "secret",
        "--auth-org", "org.com",
        "--auth-arlas-iam"
    ]

def check_inferred_types(result_output, expected_mapping, test_name):
    errors = []
    for field_name, reference_field_type in expected_mapping:
        pattern = rf"-->{field_name}:\s*([^\n]+)"
        match = re.search(pattern, result_output)
        detected_type = match.group(1).strip()
        if detected_type != reference_field_type:
            errors.append(f"Field '{field_name}': '{detected_type}' instead of '{reference_field_type}'")

    if errors:
        pytest.fail(f"Wrong types detected for {test_name}\n" + "\n".join(f"❌ {error}" for error in errors))
