import json
import sys
from pathlib import Path
from typing import Iterator, Dict, Any

from arlas.cli.utils import clean_str
from arlas.cli.variables import FileType


def read_ndjson_generator(
    file_path: str,
    max_lines: int = -1
) -> Iterator[Dict[str, Any]]:
    """
    Reads a NDJSON file line by line. Handles each line as a separate JSON object.

    Args:
        file_path (str): Path to the NDJSON file.
        max_lines (int, optional): Maximum number of lines to read. Defaults to -1 (read all).

    Yields:
        Iterator[Dict[str, Any]]: Each parsed JSON object from the file.
    """
    with open(file_path, "rb") as f:
        for i, line in enumerate(f, 1):
            if i > max_lines > -1:
                break
            line = line.strip()
            if not line:  # Skip empty lines
                continue
            try:
                # Parse each line individually as JSON
                yield json.loads(line)
            except json.JSONDecodeError as e:
                print(f"Error parsing line {i}: {e}", file=sys.stderr)
                continue


def get_data_generator(file_path: str, file_type: FileType = FileType.JSON, max_lines: int = -1):
    """
    Returns a generator to read data from a file based on its type.

    This function automatically selects the appropriate reader based on the file type
    and returns a generator that yields one document at a time, making it memory-efficient
    for large files.

    Args:
        file_path (str):
            Path to the input file.

        file_type (FileType):
            Type of the file. Can only be "json" for JSON/NDJSON files
            If None, the function will attempt to detect the type from the file extension.

        max_lines (int, optional):
            Maximum number of lines to read from the file.
            If -1, reads all lines in the file. Defaults to -1.

    Returns:
        Iterator[dict]:
            A generator that yields one document at a time from the file.
            Each document is a dictionary representing one record from the file.

    Raises:
        TypeError:
            If the file type is not supported or cannot be determined.
        FileNotFoundError:
            If the specified file does not exist.
    """
    if file_type == FileType.JSON or file_path.endswith(".json") or file_path.endswith(".ndjson"):
        data_generator = read_ndjson_generator(file_path=file_path, max_lines=max_lines)
    else:
        raise TypeError(f"Unknow type for file: '{file_path}'")
    return data_generator


def clean_columns_name(columns_name: list[str]) -> list[str]:
    """
    Clean a list of column names to make them valid identifiers.
    If a column name is modified, a warning message is printed to indicate the change.

    Args:
        columns_name (list[str]): List of column names to clean (can contain accents, spaces, or special characters).

    Returns:
        list[str]: List of cleaned column names, without accents, and with underscores replacing non-alphanumeric chars.
    """
    cleaned_columns_names = []
    for orig_name in columns_name:
        clean_name = clean_str(orig_name)
        if clean_name != orig_name:
            print(f"Warning: Column '{orig_name}' has been renamed '{clean_name}' to prevent any encoding issues")
        cleaned_columns_names.append(clean_name)
    return cleaned_columns_names


def ensure_is_file(file_path: str):
    """
    Check if the given path exists and is a file.

    Args:
        file_path (str): Path to the file to check.

    Raises:
        FileNotFoundError: If the path does not exist.
        IsADirectoryError: If the path is a directory.

    Notes:
        This function does not return anything. It raises an exception if the path is invalid.
        If no exception is raised, the path is guaranteed to be an existing file.
    """
    file_path = Path(file_path)

    # Check if the path exists
    if not file_path.exists():
        raise FileNotFoundError(f"The path '{file_path}' does not exist.")

    # Check if the path is a directory
    if file_path.is_dir():
        raise IsADirectoryError(f"The path '{file_path}' is a directory, not a file.")
