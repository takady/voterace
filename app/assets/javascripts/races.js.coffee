@share_button = (d, id, src) ->
  return if d.getElementById(id)

  ref = d.getElementsByTagName('script')[0]
  js = d.createElement('script')
  js.id = id
  js.src = src
  ref.parentNode.insertBefore(js, ref)
