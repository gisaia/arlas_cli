import json
import typer
import os
import sys
from prettytable import PrettyTable

from arlas.cli.settings import Resource
from arlas.cli.service import Service
from arlas.cli.variables import variables

persist = typer.Typer()


@persist.callback()
def configuration(config: str = typer.Option(help="Name of the ARLAS configuration to use from your configuration file ({}).".format(variables["configuration_file"]))):
    variables["arlas"] = config


@persist.command(help="Add an entry, returns its ID", name="add")
def add(
    file: str = typer.Argument(help="File path"),
    zone: str = typer.Argument(help="zone"),
    name: str = typer.Option(help="name", default="none"),
    reader: list[str] = typer.Option(help="Readers", default=[]),
    writer: list[str] = typer.Option(help="writers", default=[]),
    encode: bool = typer.Option(help="Encode in BASE64", default=False)
):
    config = variables["arlas"]
    id = Service.persistence_add_file(config, Resource(location=file), zone=zone, name=name, readers=reader, encode=encode)
    print(id)


@persist.command(help="Delete an entry", name="delete")
def delete(
    id: str = typer.Argument(help="entry identifier")
):
    config = variables["arlas"]
    Service.persistence_delete(config, id=id)
    print("Resource {} deleted.".format(id))


@persist.command(help="Retrieve an entry", name="get")
def get(
    id: str = typer.Argument(help="entry identifier")
):
    config = variables["arlas"]
    print(Service.persistence_get(config, id=id).get("doc_value"))


@persist.command(help="List entries within a zone", name="zone")
def zone(
    zone: str = typer.Argument(help="Zone name")
):
    config = variables["arlas"]
    table = Service.persistence_zone(config, zone=zone)
    tab = PrettyTable(table[0], sortby="name", align="l")
    tab.add_rows(table[1:])
    print(tab)


@persist.command(help="List groups allowed to access a zone", name="groups")
def groups(
    zone: str = typer.Argument(help="Zone name")
):
    config = variables["arlas"]
    table = Service.persistence_groups(config, zone=zone)
    tab = PrettyTable(table[0], sortby="group", align="l")
    tab.add_rows(table[1:])
    print(tab)


@persist.command(help="Describe an entry", name="describe")
def describe(
    id: str = typer.Argument(help="entry identifier")
):
    config = variables["arlas"]
    table = Service.persistence_describe(config, id=id)
    tab = PrettyTable(table[0], sortby="metadata", align="l")
    tab.add_rows(table[1:])
    print(tab)
