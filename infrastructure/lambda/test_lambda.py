from unittest.mock import MagicMock
from get_count import lambda_handler

mock_table = MagicMock()


def test_lambda_handler_success():
    mock_table.get_item.return_value = {
        'Item': {'ID': '0', 'visit_count': 3}
    }

    event = {}
    context = {}

    response = lambda_handler(event, context, mock_table)

    assert response == 4


if __name__ == '__main__':
    test_lambda_handler_success()
