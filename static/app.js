function initializeEventSource() {
    const eventSource = new EventSource("/StreamEvents");

    eventSource.onopen = function () {
        console.log("Connection opened.");
    };
    eventSource.onerror = function (err) {
        console.error("EventSource failed:", err);
    };
    eventSource.onmessage = function (event) {
        console.log("Received message:", event.data);
    };

    return eventSource;
}


function closeEventSource() {
    console.log("Closing connection.");
    if (eventSource != null) {
        eventSource.close();
    }
}

let eventSource = initializeEventSource();

document.addEventListener('turbolinks:load', function () {
    eventSource = initializeEventSource()
});

document.addEventListener('DOMContentLoaded', function () {
    eventSource = initializeEventSource();
});

document.addEventListener('turbolinks:before-cache', function () {
    closeEventSource();
});

document.addEventListener('turbolinks:before-visit', function () {
    closeEventSource();
});


document.addEventListener('beforeunload', function () {
    closeEventSource();
});


