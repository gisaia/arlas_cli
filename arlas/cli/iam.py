
import sys
import typer

from arlas.cli.settings import Configuration
from arlas.cli.variables import variables

iam = typer.Typer()


@iam.callback()
def configuration(config: str = typer.Option(help="Name of the ARLAS configuration to use from your configuration file ({}).".format(variables["configuration_file"]))):
    variables["arlas"] = config
    if Configuration.settings.arlas.get(config, None):
        print("Error: arlas configuration {} not found among [{}]".format(config, ", ".join(Configuration.settings.arlas.keys())), file=sys.stderr)
        exit(1)
