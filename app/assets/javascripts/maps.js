function initMap() {


    var locations = $('#maplocations').data('maplocations-id');
    var kanzumes = $('#kanzumes').data('kanzumes-id');
    var myLatlng = new google.maps.LatLng(35.4478586, 139.6378361);
    var mapOptions = {
        canter: myLatlng,
        disableDefaultUI: true,
        styles: [{
                "elementType": "geometry.stroke",
                "stylers": [{
                    "visibility": "off"
                }]
            },
            {
                "elementType": "labels",
                "stylers": [{
                    "visibility": "simplified"
                }]
            },
            {
                "featureType": "landscape",
                "elementType": "geometry.fill",
                "stylers": [{
                    "color": "#82d7ff"
                }]
            },
            {
                "featureType": "poi.attraction",
                "elementType": "geometry.fill",
                "stylers": [{
                    "color": "#002573"
                }]
            },
            {
                "featureType": "poi.business",
                "elementType": "geometry.fill",
                "stylers": [{
                    "color": "#FFED00"
                }]
            },
            {
                "featureType": "poi.government",
                "elementType": "geometry.fill",
                "stylers": [{
                    "color": "#d0d47b"
                }]
            },
            {
                "featureType": "poi.medical",
                "elementType": "geometry.fill",
                "stylers": [{
                    "color": "#e6e7b2"
                }]
            },
            {
                "featureType": "poi.medical",
                "elementType": "labels.icon",
                "stylers": [{
                    "color": "#3d9538"
                }]
            },
            {
                "featureType": "poi.medical",
                "elementType": "labels.text",
                "stylers": [{
                    "color": "#3d9538"
                }]
            },
            {
                "featureType": "poi.park",
                "elementType": "geometry.fill",
                "stylers": [{
                    "color": "#e2ffb0"
                }]
            },
            {
                "featureType": "poi.place_of_worship",
                "elementType": "geometry.fill",
                "stylers": [{
                    "color": "#d0e711"
                }]
            },
            {
                "featureType": "poi.school",
                "elementType": "geometry.fill",
                "stylers": [{
                    "color": "#d0e711"
                }]
            },
            {
                "featureType": "poi.sports_complex",
                "elementType": "geometry.fill",
                "stylers": [{
                    "color": "#dadb81"
                }]
            },
            {
                "featureType": "road",
                "elementType": "geometry.fill",
                "stylers": [{
                    "color": "#FCFFF6"
                }]
            },
            {
                "featureType": "transit.line",
                "elementType": "geometry.fill",
                "stylers": [{
                        "color": "#efffbd"
                    },
                    {
                        "saturation": -100
                    }
                ]
            },
            {
                "featureType": "water",
                "elementType": "geometry.fill",
                "stylers": [{
                    "color": "#BCF2F4"
                }]
            }
        ]
    }

    var map = new google.maps.Map(document.getElementById('map'), mapOptions);
    var bounds = new google.maps.LatLngBounds();
    var infoWindow = new google.maps.InfoWindow();
    var transitLayer = new google.maps.TransitLayer();


    for (var i = 0; i < locations.length; i++) {
        transitLayer.setMap(map);
        marker = new google.maps.Marker({

            position: new google.maps.LatLng(locations[i]["latitude"], locations[i]["longitude"]),

            map: map,
            icon: {
                url: "https://kanmap-pictures.s3-ap-northeast-1.amazonaws.com/uploads/kanzume_icon/picture/" + kanzumes[i]["kanzume_icon_id"] + "/" + kanzumes[i]["kanzume_icon_name"],
                scaledSize: new google.maps.Size(30, 30)
            }


        });
        // 地図表示領域をマーカー位置に合わせて拡大
        bounds.extend(marker.position);

        google.maps.event.addListener(marker, 'click', (function(marker, i) {
            return function() {
                infoWindow.setContent("Kanzumeの名前:" + kanzumes[i]["name"] + " 場所:" + locations[i]["address"]);
                infoWindow.open(map, marker);
            }
        })(marker, i));
        // 引数に指定した矩形領域を地図に収める
        map.fitBounds(bounds);



    }
    // クリックした時情報を取得
    var clickedLatlng;
    var nowmarker;
    $(function addKanzume() {

        google.maps.event.addListener(map, 'click', (function(event) {
            if (nowmarker) { //現在地マーカーが設置されている場合は消去
                nowmarker.setMap(null);
            }
            geocodeLatLng(testResults);
            // クリックした位置情報
            clickedLatlng = new google.maps.LatLng(event.latLng.lat(), event.latLng.lng());

            nowmarker = new google.maps.Marker({
                icon: {
                    url: "https://kanmap-pictures.s3-ap-northeast-1.amazonaws.com/uploads/AddKanzumeIcon2.png",
                    scaledSize: new google.maps.Size(50, 50)
                },

            });
            //marker設置
            nowmarker.setPosition(clickedLatlng);
            nowmarker.setMap(map);
            var address_name;
            var address_latlng;

            // 逆ジオコーディング
            function geocodeLatLng(callback) {
                var geocoder = new google.maps.Geocoder();
                geocoder.geocode({
                    'location': new google.maps.LatLng(event.latLng.lat(), event.latLng.lng())
                }, function(results, status) {
                    if (status === google.maps.GeocoderStatus.OK) {
                        if (results[1]) {
                            address_name = results[0].formatted_address;
                            console.log(address_name);

                            console.log(clickedLatlng.lat().toString());
                        } else {
                            alert('No results found');
                        }
                    } else {
                        alert('Geocoder failed due to: ' + status);
                    }
                });
            }

            function testResults(geoCodeResults) {
                // ジオコーディング結果を用いた処理
                console.log(geoCodeResults);
            }

            //Window内のボタン
            var a_btn = document.createElement("button");
            a_btn.innerText = " a";
            google.maps.event.addDomListener(a_btn, "click", function() {
                $.ajax({
                    type: "GET",
                    url: "/kanzumes/new",
                    data: {
                        address_name: address_name,
                        address_latitude: clickedLatlng.lat().toString(),
                        address_longitude: clickedLatlng.lng().toString()
                    },
                    dataType: 'html',
                    success: function(data) {
                        var win = window.open();
                        win.document.write(data);
                    }
                });
            });
            infoWindow.setContent(
                a_btn
            );
            infoWindow.open(map, nowmarker); // 吹き出しの表示
        }));
    });



    var geoOptions = {
        enableHighAccuracy: true, //精度を高める
        timeout: 6000, //タイムアウトは6秒
        maximumAge: 0 //キャッシュはさせない
    }

    $("#currentPosition").click(function() {
        if (navigator.geolocation) {
            window.navigator.geolocation.getCurrentPosition(
                function(result) {
                    //現在地の取得成功
                    if (marker) { //現在地マーカーが設置されている場合は消去
                        marker.setMap(null);
                    }
                    var position = result.coords,
                        radius = position.accuracy,
                        latLng = new google.maps.LatLng(position.latitude, position.longitude)
                        //現在地へマップをズームして移動
                    map.setZoom(16);
                    map.setCenter(latLng);
                    marker = new google.maps.Marker({
                        position: latLng,
                        map: map,
                        icon: 'https://kanmap-pictures.s3-ap-northeast-1.amazonaws.com/uploads/NowLocationIcon2.png',
                        scaledSize: new google.maps.Size(1, 1)
                    });
                },
                function(error) {
                    //取得失敗
                    alert("エラーが発生しました。");
                }, {
                    enableHighAccuracy: true
                });
        }


    });
}