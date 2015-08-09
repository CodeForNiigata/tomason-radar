# 現在地の更新間隔(ms)
updatePositionInterval = 5 * 1000

# 近いと認識する緯度経度差(m)
distance = 25

# 地図のスタイル
styleName = 'radar'
mapStyles = [
  stylers: [
    {visibility: 'simplified'}
    {invert_lightness: 'false'}
    {hue: '#00ff00'}
    {saturation: 1}
  ],
  {
    featureType: 'road'
    elementType: 'geometry'
    stylers: [
      {visibility: 'simplified'}
    ]
  },
  {
    featureType: 'road'
    elementType: 'labels'
    stylers: [
      {visibility: 'off'}
    ]
  }
]

map = undefined
me = undefined
tomasons = []

execCurrentPosition = (func) ->
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition (position) ->
      func(position.coords.latitude, position.coords.longitude)
  else
    console.log 'can not get current position.'

execWithInterval = (func) ->
  func()
  setInterval(func, updatePositionInterval)


createMap = (lat, lng)->
  $div = $('<div class="map"></div>')
  $('body').prepend($div)

  $map = $('.map')
  $window =$(window)
  $map
    .width $window.width()
    .height $window.height()

  opts =
    mapTypeControlOptions:
      mapTypeIds: [google.maps.MapTypeId.ROADMAP, styleName]
    center: new google.maps.LatLng(lat, lng)
    zoom: 20
    draggable: false
  map = new google.maps.Map($map[0], opts)

  styledMap = new google.maps.StyledMapType(mapStyles, {name: styleName})
  map.mapTypes.set styleName, styledMap
  map.setMapTypeId styleName


loadTomasons = () ->
  $.get 'http://www.codeforniigata.org/mp/data/data.txt', (data) ->
    datas = data.split(/\r\n|\r|\n/)
    _.each datas, (line) ->
      src = line.split(/,/)
      marker =
        lat: src[0]
        lng: src[1]
        date: src[2]
        title: src[3]
        owner: src[4]
        description: src[5]
        category: src[6]
        image: "http://www.codeforniigata.org/mp/images/#{src[7]}"
        isShow: false
      tomasons.push marker
    _.each tomasons, (marker) ->
      createTomason(marker)

createTomason = (tomason)->
  marker = new google.maps.Marker
    position: new google.maps.LatLng(tomason.lat, tomason.lng)
    map: map
    icon: './img/pointer.png'

showTomason = (tomason) ->
  $('#modal-marker .photo').attr
    'src': tomason.image
  $('#modal-marker .title').text(tomason.title)
  tomason.isShow = true
  $('#modal-marker').modal()

searchNearestTomason = (lat, lng)->
  currentLatlng = new google.maps.LatLng(lat, lng)
  nearTomasons = _.filter tomasons, (obj) ->
    tomasonLatlng = new google.maps.LatLng(obj.lat, obj.lng)
    diff = google.maps.geometry.spherical.computeDistanceBetween(currentLatlng, tomasonLatlng)
    return diff <= distance
  showTomason(nearTomasons[0]) if nearTomasons.length > 0


init = (lat, lng) ->
  createMap(lat, lng)
  loadTomasons()

update = ->
  func = (lat, lng) ->
    latlng = new google.maps.LatLng(lat, lng)
    me?.setMap(null) if me
    me = new google.maps.Marker
      position: latlng
      map: map
      icon: './img/self.png'
    map.panTo latlng
    searchNearestTomason(lat, lng)

  execCurrentPosition(func) if map


$ ->
  execCurrentPosition(init)
  execWithInterval(update)
