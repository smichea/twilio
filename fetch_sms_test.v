module twilio
//sid="SM854574a774a7519546c12f5c11ccf549"


fn test_fetch_sms_success() {
    // Setup
    client := TwilioClient{
        account_sid: 'ACd6******************************',
        auth_token: '76******************************',
        from_number: '+12345678901',
    }

    // Execute
    result := client.fetch_sms('SMa6******************************') or {
		eprintln(err.msg())	
        assert false // Test should not fail here
        return
    }

    // Assert
    assert result.status == 'delivered'
}