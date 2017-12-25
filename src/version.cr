require "./version/version"

module Version
  macro fetch(file)
    {{ run "./version/version_fetch", file }}
  end

  macro fetch
    fetch(__FILE__)
  end
end
