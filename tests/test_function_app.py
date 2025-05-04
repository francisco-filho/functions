from function_app import get_message

def test_get_message_defined():
    msg = get_message('World')
    assert "Hello, World" in msg