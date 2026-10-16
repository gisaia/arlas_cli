import requests
import typer
import os
import sys

from .service import Service
from arlas.cli.user import user
from arlas.cli.iam import iam
from arlas.cli.org import org
from arlas.cli.collections import collections
from arlas.cli.configurations import configurations
from arlas.cli.persist import persist
from arlas.cli.index import indices
from arlas.cli.variables import variables
from arlas.cli.settings import ARLAS, Configuration, Resource, Settings

app = typer.Typer(add_completion=False, no_args_is_help=True)
arlas_cli_version = "29.0.0-alpha.5"


@app.callback(invoke_without_command=True)
def init(
    config_file: str = typer.Option(None, help="Path to the configuration file if you do not want to use the default one: .arlas/cli/configuration.yaml."),
    print_curl: bool = typer.Option(False, help="Print curl command"),
    version: bool = typer.Option(False, "--version", help="Print command line version"),
    quiet: bool = typer.Option(False, help="Remove non-essential printing")
):
    variables["quiet"] = quiet
    if not quiet:
        # Check if version is up-to-date
        try:
            latest_version_response = requests.get('https://raw.githubusercontent.com/gisaia/arlas_cli/refs/heads/master/version.txt')
            latest_version_response.raise_for_status()
            latest_version = latest_version_response.text.strip()
            if (arlas_cli_version == latest_version or
                    arlas_cli_version.startswith("0.0.0.dev")):
                # Local dev 'python3.10 -m arlas.cli.cli' usage
                ...
            elif arlas_cli_version != latest_version:
                print("WARNING: You are not using the latest version of arlas_cli! Please update with:", file=sys.stderr)
                print("pip3.10 install \"arlas_cli@git+https://github.com/gisaia/arlas_cli.git@" + latest_version +"\"", file=sys.stderr)
        except Exception:
            print("WARNING: Can not contact github to identify if this arlas_cli is the latest version.", file=sys.stderr)
    Service.curl = print_curl
    if config_file:
        variables["configuration_file"] = config_file
    if version:
        print(arlas_cli_version)
    if os.path.exists(variables["configuration_file"]):
        Configuration.init(configuration_file=variables["configuration_file"])
        if "arlas" in dict(Configuration.settings):
            if len(Configuration.settings.arlas) > 0:
                # Configuration is ok.
                ...
            else:
                if not quiet:
                    print("Warning : no configuration available")
        else:
            print("Error : no arlas endpoint found in {}.".format(variables["configuration_file"]), file=sys.stderr)
            sys.exit(1)
    else:
        # we create a template to facilitate the creation of the configuration file
        os.makedirs(os.path.dirname(variables["configuration_file"]), exist_ok=True)
        Configuration.settings = Settings(
            arlas={
            },
            mappings={
            },
            models={
            }
        )
        Configuration.save(variables["configuration_file"])
        if not quiet:
            print(f"Warning : no configuration file found, we created a default empty one ({variables['configuration_file']}).", file=sys.stderr)
            print("Warning : no configuration available", file=sys.stderr)


def main():
    app.add_typer(collections, name="collections")
    app.add_typer(indices, name="indices")
    app.add_typer(persist, name="persist")
    app.add_typer(configurations, name="confs")
    iam.add_typer(org, name="orgs")
    iam.add_typer(user, name="users")
    app.add_typer(iam, name="iam")
    app()


if __name__ == "__main__":
    main()
