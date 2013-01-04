function extractId(obj) {
  tokens = obj.attr('id').split('-');
  return tokens[tokens.length-1];
}

$(document).ready(function (){
  if ($('#recent-comments').length) {
    $('.comment-body').hide();

    asyncUndoBehaviour();

    $('form.delete-item').submit(function () {
      asyncDeleteForm($(this));

      // Assume success and remove comment
      comment_link_id = '#comment-link-' + extractId($(this));
      $(comment_link_id).remove();
      $(this).parent('div').parent('div').remove();
      return false;
    });
  }
})
