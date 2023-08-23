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

let eventSource = initializeEventSource();

document.addEventListener('turbolinks:load', function () {
    eventSource = initializeEventSource()
});

document.addEventListener('DOMContentLoaded', function () {
    eventSource = initializeEventSource();
});

$(document).on('turbolinks:before-render turbolinks:before-visit beforeunload', function () {
    console.log("Closing connection.");
    if (eventSource != null) {
        eventSource.close();
    }
});