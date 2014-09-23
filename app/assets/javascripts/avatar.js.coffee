$ ->
  return unless $('.js-avatar').length

  $("input[type='radio']:checked", '.js-avatar').closest('.radio').addClass('selected')

  inputs = $("input[type='radio']", '.js-avatar')

  inputs.on 'click', ->
    $('.radio').removeClass('selected')

    $(this).closest('.radio').addClass('selected')
