function initMap() {

    var locations = $('#maplocations').data('maplocations-id');
    var kanzumes = $('#kanzumes').data('kanzumes-id');
    var myLatlng = new google.maps.LatLng(35.4478586, 139.6378361);

    var mapOptions = {
        canter: myLatlng,
        disableDefaultUI: true,
        styles: mapstyle
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

        //Window内のボタンを表示
        google.maps.event.addListener(marker, 'click', (function(marker, i) {
            return function() {

                var contentinfo = document.createElement("div");
                var kanzumeinfo = document.createTextNode(("Kanzumeの名前: " + kanzumes[i]["name"] + " " + "場所: " + locations[i]["address"]));
                contentinfo.appendChild(kanzumeinfo);
                var kanzume_id = kanzumes[i]["id"];
                var showKanzume_btn = document.createElement("button")
                showKanzume_btn.innerText = "このKanzumeの詳細を表示";
                google.maps.event.addDomListener(showKanzume_btn, "click", function() {
                    $.ajax({
                        type: "GET",
                        url: `/kanzumes/${kanzume_id}`,
                        dataType: 'html',
                        success: function(data) {
                            var win = window.open();
                            win.document.write(data);
                        }
                    });
                });
                contentinfo.appendChild(showKanzume_btn);
                var addItem_btn = document.createElement("button");
                addItem_btn.innerText = "このKanzumeにアイテムを入れる";
                google.maps.event.addDomListener(addItem_btn, "click", function() {
                    $.ajax({
                        type: "GET",
                        url: "/items/new",
                        data: {
                            kanzume_id: kanzume_id.toString()
                        },
                        dataType: 'html',
                        success: function(data) {
                            var win = window.open();
                            win.document.write(data);
                        }
                    });
                });
                contentinfo.appendChild(addItem_btn);

                if (c_marker) { //マーカーが設置されている場合は消去
                    c_marker.setMap(null);
                }
                infoWindow.setContent(
                    contentinfo
                );

                infoWindow.open(map, marker);
            }
        })(marker, i));


        // 引数に指定した矩形領域を地図に収める
        map.fitBounds(bounds);
        // 地図表示領域をマーカー位置に合わせて拡大
        bounds.extend(marker.position);



    };
    // 地図上をクリックした時情報を取得
    var clickedLatlng;
    var c_marker;


    $(function addKanzume() {

        google.maps.event.addListener(map, 'click', (function(event) {
            if (c_marker) { //マーカーが設置されている場合は消去
                c_marker.setMap(null);
            }
            infoWindow.close(map, marker);
            geocodeLatLng(testResults);

            // クリックした位置情報
            clickedLatlng = new google.maps.LatLng(event.latLng.lat(), event.latLng.lng());

            c_marker = new google.maps.Marker({
                icon: {
                    url: "https://kanmap-pictures.s3-ap-northeast-1.amazonaws.com/uploads/AddKanzumeIcon2.png",
                    scaledSize: new google.maps.Size(50, 50)
                },

            });
            //marker設置

            c_marker.setPosition(clickedLatlng);
            c_marker.setMap(map);



            var address_name;
            var address_latlng;
            var nowinfoWindow;

            // 逆ジオコーディング
            function geocodeLatLng(callback) {
                var geocoder = new google.maps.Geocoder();
                geocoder.geocode({
                    'location': new google.maps.LatLng(event.latLng.lat(), event.latLng.lng())
                }, function(results, status) {
                    if (status === google.maps.GeocoderStatus.OK) {
                        if (results[1]) {
                            address_name = results[0].formatted_address;
                            nowinfoWindow = new google.maps.InfoWindow();
                            kanwindowinfo(address_name, clickedLatlng, map, c_marker, undefined, nowinfoWindow);
                            nowinfoWindow.open(map, c_marker); // 吹き出しの表示
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



        }));

    });


    //現在地ボタン
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
                        icon: new google.maps.MarkerImage(
                            'https://kanmap-pictures.s3-ap-northeast-1.amazonaws.com/uploads/NowLocation.png',
                            null,
                            null,
                            null,
                            new google.maps.Size(64, 64))
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

    //検索ボタン
    var s_markers = [];
    var current_s_infoWindow = null;
    $(function searchMap() {

        var request = {
            location: new google.maps.LatLng(0, 0),
            radius: 1000, // ※１ 表示する半径領域を設定(1 = 1M)
        };
        var service;
        var service = new google.maps.places.PlacesService(map);
        service.search(request, Result_Places);

        // 検索結果を受け取る
        function Result_Places(results, status) {
            if (results) {
                for (var i = 0; i < results.length; i++) {
                    results[i] === null;
                }
            }
            // Placesが検家に成功したかとマうかをチェック
            if (status == google.maps.places.PlacesServiceStatus.OK) {
                for (var i = 0; i < results.length; i++) {
                    // 検索結果の数だけ反復処理を変数placeに格納
                    var place = results[i];
                    createMarker({
                        text: place.name,
                        position: place.geometry.location
                    });


                }
            }
        }

        // 入力キーワードと表示範囲を設定
        $("#searchGo").click(function() {
            for (var i = 0; i < s_markers.length; i++) {
                s_markers[i].setMap(null);
            }
            // #map_canva要素にMapクラスの新しいインスタンスを作成
            service = new google.maps.places.PlacesService(map);
            // input要素に入力されたキーワードを検索の条件に設定
            var myword = document.getElementById("search");
            var request = {
                query: myword.value,
                radius: 5000,
                location: map.getCenter()
            };
            service.textSearch(request, result_search);
        })

        // 検索の結果を表示
        function result_search(results, status) {

            var bounds = new google.maps.LatLngBounds();
            for (var i = 0; i < results.length; i++) {
                createMarker({
                    position: results[i].geometry.location,
                    text: results[i].name,
                    map: map,
                    icon: new google.maps.MarkerImage(
                        'https://kanmap-pictures.s3-ap-northeast-1.amazonaws.com/uploads/Searchedmarker.png',
                        null,
                        null,
                        null,
                        new google.maps.Size(32, 32))
                });
                bounds.extend(results[i].geometry.location);
            }
            map.fitBounds(bounds);
        }

        // 該当する位置にマーカーを表示
        function createMarker(options) {


            if (s_infoWindow) { s_infoWindow.close(); }
            // マップ情報を保持しているmapオブジェクトを指定
            options.map = map;

            // Markerクラスのオブジェクトmarkerを作成
            var s_marker = new google.maps.Marker(options);

            // 各施設の吹き出し(情報ウインドウ)に表示させる処理
            var s_infoWindow = new google.maps.InfoWindow();

            kanwindowinfo(options.text, options.position, map, s_marker, options.text, s_infoWindow);
            google.maps.event.addListener(s_marker, 'click', function() {
                infoWindow.close(map, marker);
                if (current_s_infoWindow) { current_s_infoWindow.close(); }
                s_infoWindow.open(map, s_marker);
                current_s_infoWindow = s_infoWindow;
            });
            s_markers.push(s_marker);
            return s_marker;

        }
    });


    // Window内情報（Kanzume）
    function kanwindowinfo(address_name, Latlng, map, marker, search_name, infoWindow) {

        var a_btn = document.createElement("button");
        if (search_name === undefined) {
            a_btn.innerText = "ここにKanzumeを追加する";
        } else {
            a_btn.innerText = `「${search_name}」にKanzumeを追加する`;
        }
        google.maps.event.addDomListener(a_btn, "click", function() {
            $.ajax({
                type: "GET",
                url: "/kanzumes/new",
                data: {
                    address_name: address_name,
                    address_latitude: Latlng.lat().toString(),
                    address_longitude: Latlng.lng().toString()
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

    }



}