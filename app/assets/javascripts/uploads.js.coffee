$ ->
  $('.direct_upload').find('input:file').each (i, elem) ->
    fileInput = $(elem)
    form = $(fileInput.parents('form:first'))
    submitButton = form.find('input[type="submit"]')
    progressBar = $("<div class='bar'></div>")
    barContainer = $("<div class='progress'></div>").append(progressBar)
    fileInput.after(barContainer)
    fileInput.fileupload
      disableImageResize: false
      imageMaxWidth: 800
      imageMaxHeight: 800
      imageCrop: true
      fileInput: fileInput
      url: s3_direct_post_url
      type: 'POST'
      autoUpload: true
      formData: s3_direct_post_form_data
      paramName: 'file'
      dataType: 'XML'
      replaceFileInput: false
      progressall: (e, data) ->
        progress = parseInt(data.loaded / data.total * 100, 10)
        progressBar.css('width', progress + '%')
      start: (e) ->
        submitButton.prop('disabled', true)

        progressBar.
          css('background', 'green').
          css('display', 'block').
          css('width', '0%').
          text('Loading...')
      done: (e, data) ->
        submitButton.prop('disabled', false)
        progressBar.text('Uploading done')

        # extract key and generate URL from response
        key = $(data.jqXHR.responseXML).find('Key').text()

        # create hidden field
        input = $ "<input />",
          type:'hidden'
          name: fileInput.attr('name')
          value: key
        form.append(input)
      fail: (e, data) ->
        submitButton.prop('disabled', false)

        progressBar.
          css('background', 'red').
          text('Failed')