let map, currentLocationMarker;
	let markers = [];

	function initMap() {
		// 現在地を取得してマップに表示
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(function(position) {
				const currentLocation = {
					lat: position.coords.latitude,
					lng: position.coords.longitude
				};

				// 現在地をセンターにして地図を初期化
				map = new google.maps.Map(document.getElementById('map'), {
					center: currentLocation,
					zoom: 15,
				});
			
				// 現在地にマーカーを配置
				const currentLocationMarker = new google.maps.Marker({
					position: currentLocation,
					map: map,
					icon: {
						path: google.maps.SymbolPath.CIRCLE,
						scale: 8,
						fillColor: '#4285F4',
						fillOpacity: 1,
						strokeColor: '#ffffff',
						strokeWeight: 2
					},
					title: "現在地"
				});

				// データベースから取得した場所にマーカーを表示
				document.addEventListener('DOMContentLoaded', function() {
          const livesData = JSON.parse(document.getElementById('lives-data').textContent);
          livesData.forEach(m => {
            const livelocation = {
              lat: m.latitude,
              lng: m.longitude
            };

						const marker = new google.maps.Marker({
							position: livelocation,
							map: map,
							title: "<%= m.artist.user.username %>"
						});

						markers.push(marker);

						const infoWindow = new google.maps.InfoWindow({
							content: `<div><p><%= m.artist.user.username %></p>
														<p><%= m.description %></div>`
						});

						// マーカーがクリックされたときにinfowindowを表示する
						marker.addListener('click', () => {
							infoWindow.open(map, marker);
						});

						// Geocoding APIで住所を取得
						const geocoder = new google.maps.Geocoder();
						geocoder.geocode({ location: livelocation }, (results, status) => {
							if (status === "OK" && results[0]) {
								const address = results[0].formatted_address;
								const addressElement = document.querySelector(`[data-lat='<%= m.latitude %>'][data-lng='<%= m.longitude %>'] .location`);
								addressElement.textContent = address;
							} else {
								console.error("Geocoder failed due to: " + status);
							}
						});
					})();
				});

				// 検索フォームのイベントリスナーを追加
				document.getElementById('location-search-form').addEventListener('submit', function (event) {
					event.preventDefault(); // フォーム送信を無効化

					const query = document.getElementById('location-input').value.trim().toLowerCase();
					const geocoder = new google.maps.Geocoder();

					geocoder.geocode({ 'address': query }, function (results, status) {
						if (status === 'OK') {
							const newCenter = results[0].geometry.location;
							map.setCenter(newCenter);
							map.setZoom(15); // 適度にズームイン

							// 新しい位置にマーカーを追加
							const marker = new google.maps.Marker({
								position: newCenter,
								map: map,
								title: query
							});
						} else {
							// アーティスト名で検索
							const foundMarker = markers.find(marker =>
								marker.getTitle().toLowerCase().includes(query)
							);

							if (foundMarker) {
								map.setCenter(foundMarker.getPosition());
								map.setZoom(18); // 適度にズームイン
								foundMarker.setAnimation(google.maps.Animation.BOUNCE); // アニメーションを追加

								// 2秒後にアニメーションを停止
								setTimeout(() => foundMarker.setAnimation(null), 2000);
							} else {
								alert('地名やアーティストが見つかりませんでした: ' + status);
							}
						}
					});
				});

				//live-itemがクリックされたとき、そこにズームインする
				document.querySelectorAll('.live-item').forEach(item => {
					item.addEventListener('click', function () {
						const lat = parseFloat(this.dataset.lat);
						const lng = parseFloat(this.dataset.lng);

						const clickedMarker = markers.find(marker =>
							marker.getPosition().lat() === lat && marker.getPosition().lng() === lng
						);

						if (clickedMarker) {
							map.setCenter(clickedMarker.getPosition());
							map.setZoom(18); // 適度にズームイン
							clickedMarker.setAnimation(google.maps.Animation.BOUNCE); // アニメーションを追加

							// 2秒後にアニメーションを停止
							setTimeout(() => clickedMarker.setAnimation(null), 2000);
						}
					});
				});

			}, function() {
				// エラーハンドリング
				alert('現在地を取得できませんでした。');
			});
		} else {
			alert('このブラウザでは現在地の取得がサポートされていません。');
		}
	}