#!/usr/bin/env ruby
require 'json'

PACKAGE_JSON = sprintf("%s/package.json", ENV['TRAVIS_BUILD_DIR'])

package_conf = File.read(PACKAGE_JSON)

package_contents = JSON.parse(package_conf)

# Update version
package_contents['version'] = ENV['TRAVIS_TAG'] ? ENV['TRAVIS_TAG'] : '0.0.0'

# Delete development dependencies
package_contents.delete("devDependencies")

##
# Remove any commands which should not be on production servers
# ex: package_contents["scripts"].delete("test")

package_contents["scripts"].delete("dev:server")
package_contents["scripts"].delete("dev:ui")
package_contents["scripts"].delete("release")
package_contents["scripts"].delete("start")
package_contents["scripts"].delete("test")
package_contents["scripts"].delete("test:local")
package_contents["scripts"].delete("test:ci")
package_contents["scripts"].delete("watch")

# print contents to CI CLI
puts JSON.pretty_generate package_contents

File.open(PACKAGE_JSON,"w") do |f|
  f.write(JSON.pretty_generate(package_contents))
end

printf("Updated package.json version: %s\n",  package_contents['version'])
