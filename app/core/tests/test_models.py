from django.test import TestCase
from django.contrib.auth import get_user_model

class ModelTests(TestCase):

    def test_create_user_with_email_successful(self):
        """
        Test createing a new user with an email is successful
        """
        email = 'test@test.com'
        password = 'Testpass123'
        user = get_user_model().objects.create_user(
            email = email,
            password = password
        )
        
        self.assertEqual(user.email, email)
        #password encrypted saved
        self.assertTrue(user.check_password(password))