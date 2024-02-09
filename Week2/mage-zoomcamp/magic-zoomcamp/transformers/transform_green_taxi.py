if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    """
    Template code for a transformer block.

    Add more parameters to this function if this block has multiple parent blocks.
    There should be one parameter for each output variable from each parent block.

    Args:
        data: The output from the upstream parent block
        args: The output from any additional upstream blocks (if applicable)

    Returns:
        Anything (e.g. data frame, dictionary, array, int, str, etc.)
    """
    # Specify your transformation logic here
    data.columns = (data.columns.str.replace('(?<=[a-z])(?=[A-Z])', '_', regex=True).str.lower())
    return data[(data['passenger_count'] > 0) & (data['trip_distance'] > 0) ]


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output['passenger_count'].isin([0]).sum() == 0, 'No Passenger count = 0'
    assert output['trip_distance'].isin([0]).sum() ==  0, 'No Trip distance = 0'
    assert 'vendor_id' in output.columns , 'Case updated'
