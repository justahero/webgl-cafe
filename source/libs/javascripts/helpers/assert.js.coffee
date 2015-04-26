@assert = (condition, description = '') ->
  unless condition
    if typeof Error != 'undefined'
      throw Error(description)
    throw description