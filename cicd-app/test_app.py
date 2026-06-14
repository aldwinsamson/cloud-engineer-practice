import json
import unittest
from unittest.mock import MagicMock, patch
import sys
import os

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from app import AppHandler, APP_VERSION

class TestAppHandler(unittest.TestCase):

    def setUp(self):
        self.handler = AppHandler.__new__(AppHandler)
        self.handler.wfile = MagicMock()
        self.handler.send_response = MagicMock()
        self.handler.send_header = MagicMock()
        self.handler.end_headers = MagicMock()
        self.handler.log_date_time_string = MagicMock(return_value="01/Jan/2026 00:00:00")

    def test_health_endpoint_returns_200(self):
        self.handler.handle_health()
        self.handler.send_response.assert_called_with(200)

    def test_health_endpoint_returns_healthy_status(self):
        self.handler.handle_health()
        written_data = self.handler.wfile.write.call_args[0][0]
        response = json.loads(written_data.decode())
        self.assertEqual(response["status"], "healthy")

    def test_health_endpoint_returns_correct_version(self):
        self.handler.handle_health()
        written_data = self.handler.wfile.write.call_args[0][0]
        response = json.loads(written_data.decode())
        self.assertEqual(response["version"], APP_VERSION)

    def test_info_endpoint_returns_200(self):
        self.handler.handle_info()
        self.handler.send_response.assert_called_with(200)

    def test_info_endpoint_returns_json(self):
        self.handler.handle_info()
        written_data = self.handler.wfile.write.call_args[0][0]
        response = json.loads(written_data.decode())
        self.assertIn("version", response)
        self.assertIn("environment", response)
        self.assertIn("hostname", response)

    def test_home_endpoint_returns_200(self):
        self.handler.path = "/"
        self.handler.handle_home()
        self.handler.send_response.assert_called_with(200)

    def test_version_is_set(self):
        self.assertIsNotNone(APP_VERSION)
        self.assertNotEqual(APP_VERSION, "")

if __name__ == "__main__":
    unittest.main()