window.stacks = []

$().ready ->
  $('#delete').on 'click', ->
    delete_stacks()
  $('#clear').on 'click', ->
    clear_stacks()
  $('#copy').on 'click', ->
    copy()
  init_cards()

add_stacks = (num)->
  return if window.stacks.length >= 9
  return if window.stacks.indexOf(num) >= 0
  window.stacks.push(num)
  output()

delete_stacks = ->
  return if window.stacks.length <= 0
  window.stacks.pop()
  output()

clear_stacks = ->
  window.stacks = []
  output()

output = ->
  $('#viewer').html('')
  tr = $('<tr>')
  for num in window.stacks
    $(tr).append(
      $('<td>').append(
        $('<img>').attr('src', './img/'+num+'.png')
      )
    )
  $('#viewer').append(tr)

  $('#string').val stacks_to_str()
  copy()

copy = ->
  strs = []
  for num in window.stacks
    strs.push num_to_str(num)
  navigator.clipboard.writeText(stacks_to_str())

stacks_to_str = ->
  strs = []
  for num in window.stacks
    strs.push num_to_str(num)
  strs.join("\t")

init_cards = ->
  for suit in [0...4]
    tr = $('<tr>')
    for pow in [12..0]
      num = suit * 13 + pow + 1
      str = num_to_str(num)
      tr.append(
        $('<td>').append(
          $('<img>').attr('src', './img/'+num+'.png').attr('string', str).attr('num', num)
            .on('click', ->
              add_stacks Number $(@).attr('num')
          )
        )
      )
    $('#trumps').append tr

num_to_str = (num)->
  num = num - 1
  suit = num // 13
  pow = num % 13
  str_suit = switch suit
    when 0 then 's'
    when 1 then 'd'
    when 2 then 'h'
    when 3 then 'c'
  str_power = if pow <= 7
    ''+(pow+2)
  else if pow is 8
    'T'
  else if pow is 9
    'J'
  else if pow is 10
    'Q'
  else if pow is 11
    'K'
  else if pow is 12
    'A'
  str_power+str_suit