class Array
  def promote(element)
    return self unless (found_index = find_index(element))
    unshift(delete_at(found_index))
  end
end
