#= require jquery
#= require ../vendor/gl-matrix/gl-matrix.js
#= require cafe

selectedSample = null

@load_sample = (sample) ->
  unless selectedSample == sample
    selectedSample = sample
    viewer = document.getElementById('viewer')
    viewer.src = "examples/#{sample}"
    viewer.focus()

@reset_sample = () ->
  viewer = document.getElementById('viewer')
  viewer.src = ""
