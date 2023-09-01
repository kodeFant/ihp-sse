document.addEventListener('turbolinks:load', () => {
    htmx.process(document.body);
});


function initializeEventSource() {
    const eventSource = new EventSource("/StreamPostsEvents");

    eventSource.onopen = function () {
        console.log("Connection opened.");
    };
    eventSource.onerror = function (err) {
        console.error("EventSource failed:", err);
    };
    eventSource.onmessage = function (event) {
        console.log("Received message:", event.data);
    };

    eventSource.addEventListener('ping', function (e) {
        console.log('ping', e.data);
    }, false);

    eventSource.addEventListener('posts_updated', function (e) {
        const notificationSound = new Audio("/msn-sound.wav")
        notificationSound.play();
        console.log('posts_updated', e);
    }, false);

    return eventSource;
}

// let eventSource = initializeEventSource();

// function closeEventSource() {
//     console.log("Closing connection.");
//     if (eventSource != null) {
//         eventSource.close();
//     }
// }

// document.addEventListener('turbolinks:load', function () {
//     eventSource = initializeEventSource()
// });

// document.addEventListener('DOMContentLoaded', function () {
//     eventSource = initializeEventSource();
// });

// document.addEventListener('turbolinks:before-cache', function () {
//     closeEventSource();
// });

// document.addEventListener('turbolinks:before-visit', function () {
//     closeEventSource();
// });


// document.addEventListener('beforeunload', function () {
//     closeEventSource();
// });


