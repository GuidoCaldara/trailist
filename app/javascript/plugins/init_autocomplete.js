import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('organization_location');
  const raceLocation = document.getElementById('race_location');
  if (addressInput) {
    places({ container: addressInput });
  }
  if (raceLocation) {
    places({ container: raceLocation });
  }

};

export { initAutocomplete };
