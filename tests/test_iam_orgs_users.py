from tests.conftest import run_cli_command


def test_create_configuration():
    """Test creating a new configuration."""
    configuration_parameters = [
        "confs", "create", "tests_orgs",
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
        "--auth-login", "user@org2.com",
        "--auth-password", "secret",
        "--auth-org", "org2.com",
        "--auth-arlas-iam"
    ]
    print(" ".join(configuration_parameters))
    result = run_cli_command(configuration_parameters)
    assert "tests_orgs" in result.stdout, result.stderr

def test_create_admin_configuration():
    """Test creating a new configuration."""
    configuration_parameters = [
        "confs", "create", "local.iam.admin",
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
        "--auth-login", "tech@gisaia.com",
        "--auth-password", "admin",
        "--auth-arlas-iam"
    ]
    result = run_cli_command(configuration_parameters)
    assert "local.iam.admin" in result.stdout, result.stderr

def test_create_user():
    """Test to create a user"""
    result = run_cli_command(["iam", "--config", "tests_orgs", "users", "add", "user@org2.com"])
    assert result.returncode == 0, f"Failed to create user: {result.stderr}"

def test_user_check_orgs_exists_nok_missing():
    """Test that user has no organisation"""
    result = run_cli_command(["iam", "--config", "tests_orgs", "orgs", "check"])
    assert "False" in result.stdout, f"{result.stderr}"

def test_create_organisation():
    """Test creating a new organisation."""
    result = run_cli_command(["iam", "--config", "local.iam.admin", "orgs", "add", "org2.com"])
    assert result.returncode == 0, f"Failed to create organisation: {result.stderr}"
    result = run_cli_command(["iam", "--config", "local.iam.admin", "orgs", "list"])
    assert "org2.com" in result.stdout, f"Failed to create organisation: {result.stderr}"

def test_user_check_orgs_exists_ok_out():
    """Test if user can check the organisation before being added to it"""
    result = run_cli_command(["iam", "--config", "tests_orgs", "orgs", "check"])
    assert "True" in result.stdout, f"{result.stderr}"

def test_add_user_in_org():
    # Add user in org
    result = run_cli_command(["iam", "--config", "local.iam.admin", "orgs", "add_user", "org2.com", "user@org2.com"])
    assert result.returncode == 0, f"Failed to add user to organisation: {result.stderr}"
    # Check that user is part of org users
    result = run_cli_command(["iam", "--config", "local.iam.admin", "orgs", "users", "org2.com"])
    assert "user@org2.com" in result.stdout, f"Failed to add user to organisation: {result.stderr}"

def test_user_check_orgs_exists_ok():
    """Test if user can check the organisation after being added to it"""
    result = run_cli_command(["iam", "--config", "tests_orgs", "orgs", "check"])
    assert "True" in result.stdout, f"{result.stderr}"

def test_clean_organisation():
    """Test deleting organisation."""
    result = run_cli_command(["iam", "--config", "local.iam.admin", "orgs", "delete", "org2.com"])
    assert result.returncode == 0, f"Failed to delete organisation: {result.stderr}"
