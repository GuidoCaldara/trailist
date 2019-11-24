
const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 7, duration: 0 });
};


const initMapbox = (mapElement) => {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: mapElement,
      style: 'mapbox://styles/mapbox/streets-v10'
    });

    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow); // add this
    new mapboxgl.Marker()
      .setLngLat([ marker.lng, marker.lat ])
      .addTo(map)
      .setPopup(popup)
    });
    if (mapElement.id.includes("index")) {
      window.indexMap = map
    }
    fitMapToMarkers(map, markers);

};




// const initMapbox = () => {
//   const mapElement = document.getElementById('race-show-map');
//   if (mapElement) { // only build a map if there's a div#map to inject into
//     const accessToken = mapElement.dataset.mapboxApiKey;
//     const markers = JSON.parse(mapElement.dataset.markers);
//     var myIcon = L.icon({
//       iconUrl: mapElement.dataset.icon,
//           iconSize:     [48, 48], // size of the icon
//         });
//     var mymap = L.map('race-show-map');
//     L.tileLayer(`https://api.mapbox.com/styles/v1/guidocaldara/ck2ix1ozv3aba1coh03hmc3cn/tiles/256/{z}/{x}/{y}?access_token=${accessToken}`, {
//     attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
//     maxZoom: 10,
//     id: 'mapbox.streets',
//     accessToken: accessToken
//   }).addTo(mymap);

//     markers.forEach((marker)=>{
//     var marker = L.marker([marker.lat, marker.lng],{icon: myIcon}).addTo(mymap);
//     })
//   };
// }




export { initMapbox };
