import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';
const mapElement = document.getElementById('map');

const buildMap = () => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/davidhab/cjsyo1nc1bg3u1foftwwpw93j',
    center: [4.835659, 45.764043]
  });
};

//const addMarkersToMap = (map, markers) => {
//  markers.forEach((marker) => {
//    new mapboxgl.Marker()
//      .setLngLat([ marker.lng, marker.lat ])
//      .addTo(map);
//
//  });
//};

const addMarkersToMap = (map, markers) => {
   markers.forEach((marker) => {
     const popup = new mapboxgl.Popup().setHTML(marker.infoWindow); // <-- add this
     const element = document.createElement('div');
     element.className = 'marker';
     element.style.backgroundImage = `url('${marker.image_url}')`;
     element.style.backgroundSize = 'contain';
     element.style.width = '25px';
     element.style.height = '25px';

     new mapboxgl.Marker(element)
       .setLngLat([ marker.lng, marker.lat ])
       .setPopup(popup)
       .addTo(map);
   });
 };


const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  setTimeout(() => {
    map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
  }, 200);
};

const initMapbox = () => {
  if (mapElement) {
    const map = buildMap();
    const markers = JSON.parse(mapElement.dataset.markers);
    console.log(markers);
    addMarkersToMap(map, markers);
    fitMapToMarkers(map, markers);
  }
};


export { initMapbox };
