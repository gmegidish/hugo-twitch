const express = require('express');
const bodyParser = require('body-parser')
const exec = require('child_process').exec;

const app = express();
app.use(bodyParser.urlencoded({ extended: false }))

const send_key = (digit) => {
	let key = 0;

	console.log("Handling digit " + digit);
	switch (digit) {
		case '6':
			key = "0xff53";
			break;

		case '4':
			key = "0xff51";
			break;

		case '8':
			key = "0xff52";
			break;

		case '2':
			key = "0xff54";
			break;
	}

	if (key) {
		console.log("Translated into " + key);
		exec('xdotool search -class dosbox', (err, stdout, stderr) => {
			const window_id = stdout;
			console.log("Found window " + window_id);
			exec('xdotool windowactivate ' + window_id, (err, stdout, stderr) => {
				exec('xdotool key ' + key, (err, stdout, stderr) => {
					console.log("Key sent");
				});
			});
		});
		//
		// c
	}
}

app.post('/twilio', (req, res) => {
	console.dir(req.body);

	if (req.body.Digits) {
		send_key(req.body.Digits.charAt(0));
	}

	res.contentType("text/xml");
	res.send('<?xml version="1.0" encoding="UTF-8"?><Response><Gather numDigits="1"></Gather><Redirect>/twilio</Redirect></Response>');
})

app.listen(3000, () => {
	console.log("Now listening...");
});
