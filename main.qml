import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Material.theme: Material.Dark

    TextField {
        id: searchTextField
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        selectByMouse: true
        font.pointSize: 20
    }

    Button {
        id: requestButton
        anchors.top: searchTextField.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        text: "SEND REQUEST"
        onClicked: {
            var myUrl = "https://geocoder.api.here.com/6.2/geocode.json?app_id=98ogZ6za2kYuh97ECLwd&app_code=VHAXDPHTID7wr7HbYGTxwg&searchtext=navojoa+sonora+mexico"
            var myRequest = {
                "method": "GET", // GET, POST, PATCH, PUT, DELETE
                //"url": myUrl,
                "url": "https://serpapi.com/search.json?q=" + searchTextField.text + "&source=homepage",
                "async": true, // sin tiempo
                "requestData": null
            };
            sendRequest(myRequest);
        }
    }

    ColumnLayout {
        anchors.top: requestButton.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            TextArea {
                id: textArea
                selectByKeyboard: true
                selectByMouse: true
                wrapMode: TextArea.WrapAtWordBoundaryOrAnywhere
                font.pointSize: 20
            }
        }
    }

    function sendRequest(request) {
        var xmlHttpRequest = new XMLHttpRequest();
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState === 4  && xmlHttpRequest.status === 200) {
                var xmlHttpResponseText = xmlHttpRequest.responseText;
                textArea.text = xmlHttpResponseText;
            }
        };
        // opens the connection to the server
        xmlHttpRequest.open(request.method, request.url, request.async);

        // sends instruction to the server
        xmlHttpRequest.send(request.requestData);
    }
}
