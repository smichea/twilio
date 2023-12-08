module twilio

fn test_send_sms_success() {
    // Setup
    client := TwilioClient{
        account_sid: 'ACd6******************************',
        auth_token: '76******************************',
        from_number: '+12345678901',
    }

    // Execute
    result := client.send_sms('+987654321', 'Hello tVilio') or {
		eprintln(err.msg())	
        assert false // Test should not fail here
        return
    }

    // Assert
    assert result.status == 'queued'
    assert result.body == 'Hello tVilio'
}

fn test_send_sms_failure() {
    // Setup
    client := TwilioClient{
        account_sid: 'ACd6******************************',
        auth_token: '76******************************',
        from_number: '+12345678901',
    }

    // Execute
    result := client.send_sms('+987654321', 'Hello World') or {
        eprintln(err.msg())
        assert false // Test should not fail here
        return
    }

    print(result)
    // Assert
    assert result.status == ''
    assert result.sid == ''
}

// Additional test cases...
