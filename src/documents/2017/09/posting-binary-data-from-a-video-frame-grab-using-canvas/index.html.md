---
layout: post
title: Posting Binary from a Video Frame Grab Using Canvas
date: 2017-09-21
---

I recently needed to grab a frame of video from a WebRTC video element and post that to the [Azure emotion cognitivie service API](https://azure.microsoft.com/en-us/services/cognitive-services/emotion/). A few parts were tricky to figured out, so here it is.

This is what my canvas looks like:

    <canvas id="screenshotCanvas">
    </canvas>

### Getting a frame of video

    //Grab the actual DOM element
    var canvas = document.getElementById('screenshotCanvas');
    var context = canvas.getContext('2d');
    
`video` = the video DOM element

    context.drawImage(video, 0, 0, 220, 150);

Get the binary data from the canvas

    canvas.toBlob(callback)

### Posting the binary data

    return fetch('https://westus.api.cognitive.microsoft.com/emotion/v1.0/recognize',
        {   method: 'POST',
            headers: {
                'Ocp-Apim-Subscription-Key': API_KEY,
                'Content-Type': 'application/octet-stream' },
            body: data })
    .then(function(response) {
        return response.json();
    })
    .then(function(json) {
        console.log('Emotion response: ' + JSON.stringify(json[0].scores));
    });