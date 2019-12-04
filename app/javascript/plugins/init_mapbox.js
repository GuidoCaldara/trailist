
const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 9, duration: 0 });
};

  const higlightMarker = (e) =>{
    const id = e.currentTarget.dataset.raceId
    const marker = document.querySelector(`[data-marker-race-id='${id}'`)
    const highlitedMarker = document.querySelector(".marker.highlight")
    if (highlitedMarker) highlitedMarker.classList.remove("highlight")
    marker.classList.add("highlight")
  }

const createMarkers = (map, markers) =>{
  markers.forEach((marker) => {
  const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
    const element = document.createElement('div');
    element.dataset.markerRaceId = marker.race_id
    element.className = 'marker';
     new mapboxgl.Marker(element)
    .setLngLat([ marker.lng, marker.lat ])
    .addTo(map)
    .setPopup(popup)
  });
}

const initMapbox = (mapElement) => {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: mapElement,
      style: 'mapbox://styles/mapbox/streets-v10'
    });

    const markers = JSON.parse(mapElement.dataset.markers);
    createMarkers(map, markers)
    if (mapElement.id.includes("index")) {
      window.indexMap = map
    }
    fitMapToMarkers(map, markers);
    const cards = document.querySelectorAll(".race-card")
    cards.forEach((card) => {
     card.addEventListener('mouseenter', higlightMarker)
  })
};

export { initMapbox };
