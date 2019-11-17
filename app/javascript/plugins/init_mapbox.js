import * as L from 'leaflet'


const initMapbox = () => {
  const mapElement = document.getElementById('race-show-map');
  if (mapElement) { // only build a map if there's a div#map to inject into
    const accessToken = mapElement.dataset.mapboxApiKey;
    const markers = JSON.parse(mapElement.dataset.markers);
    var myIcon = L.icon({
      iconUrl: mapElement.dataset.icon,
          iconSize:     [48, 48], // size of the icon
        });
    var mymap = L.map('race-show-map');
    L.tileLayer(`https://api.mapbox.com/styles/v1/guidocaldara/ck2ix1ozv3aba1coh03hmc3cn/tiles/256/{z}/{x}/{y}?access_token=${accessToken}`, {
    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
    maxZoom: 10,
    id: 'mapbox.streets',
    accessToken: accessToken
  }).addTo(mymap);

    markers.forEach((marker)=>{
    var marker = L.marker([marker.lat, marker.lng],{icon: myIcon}).addTo(mymap);
    })
  };
}




export { initMapbox };
