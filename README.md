
# smichea.twilio

`smichea.twilio` is a Vlang module for interacting with Twilio's SMS services. It provides an easy-to-use interface for sending SMS messages and fetching the details of sent messages using Twilio's API. This module abstracts the complexities of HTTP requests and JSON parsing, offering simple methods for these tasks.

## Features

- Send SMS messages using Twilio.
- Fetch details of sent SMS messages.
- Easy integration with Twilio API using basic authentication.
- Automatic parsing of Twilio's responses into Vlang structures.

## Installation

To install `smichea.twilio`, use the V package manager:

```bash
v install smichea.twilio
```

## Usage

Before using the module, ensure you have set up your Twilio account and obtained your Account SID, Auth Token, and a Twilio phone number.

### Setting Up

Import the module and initialize the `TwilioClient` with your Twilio credentials:

```v
import smichea.twilio

client := twilio.TwilioClient{
    account_sid: '<your_account_sid>',
    auth_token: '<your_auth_token>',
    from_number: '<your_twilio_phone_number>',
    api_version: '2010-04-01' // Optional, defaults to '2010-04-01'
}
```

### Sending an SMS

To send an SMS:

```v
result := client.send_sms('<recipient_phone_number>', '<message_body>') or {
    println('Error sending SMS: $err')
    return
}

println('SMS id (SID): ${result.sid}')
```

### Fetching SMS Details

To fetch the details of a sent SMS by its SID:

```v
sms_sid := '<sms_sid>'
details := client.fetch_sms(sms_sid) or {
    println('Error fetching SMS details: $err')
    return
}

println('SMS details: $details')
```

## Contributions

Contributions to `smichea.twilio` are welcome! Please submit a pull request or open an issue for any features, bug fixes, or improvements.

## License

This module is released under AGPLv3 licence. Please see the `LICENSE.txt` file for more details.
