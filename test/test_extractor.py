import pytest
import pandas as pd

from src import extractor


def test_add_positives():
    assert extractor.add(1, 2) == 3


def test_add_negatives():
    assert extractor.add(-1, -2) == -3


def test_add_zero():
    assert extractor.add(0, 0) == 0



#Data Frame
@pytest.mark.parametrize("input_data, expected_data", [
    ({'A': [1, 2, 3], 'B': [4, 5, 6]}, {'A': [2, 4, 6], 'B': [8, 10, 12]}),
    ({'A': [0, 0, 0], 'B': [0, 0, 0]}, {'A': [0, 0, 0], 'B': [0, 0, 0]}),
    # Add more test cases as needed
])
def test_process_data(input_data, expected_data):
    # Input DataFrame
    input_df = pd.DataFrame(input_data)

    # Expected output DataFrame
    expected_df = pd.DataFrame(expected_data)

    # Call the function
    result_df = extractor.process_data(input_df)

    # Use Pytest's assert function to check if the DataFrames are equal
    pd.testing.assert_frame_equal(result_df, expected_df)
