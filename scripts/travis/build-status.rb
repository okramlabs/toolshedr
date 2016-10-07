#!/usr/bin/env ruby
require 'travis'
require 'waitutil'


# if puts rails.job('21.1').red? exit



def are_builds_finished(build_nr)
  puts "Checking are previous jobs done ..."
  toolshedr = Travis::Repository.find('mkungla/toolshedr')
  return (toolshedr.job(sprintf("%d.1", build_nr)).finished? &&
      toolshedr.job(sprintf("%d.2", build_nr)).finished? &&
      toolshedr.job(sprintf("%d.3", build_nr)).finished? &&
      toolshedr.job(sprintf("%d.4", build_nr)).finished? &&
      toolshedr.job(sprintf("%d.5", build_nr)).finished?
  )
end

def are_we_ready_to_continue(build_nr)
  toolshedr = Travis::Repository.find('mkungla/toolshedr')
  return (toolshedr.job(sprintf("%d.1", build_nr)).green? &&
      toolshedr.job(sprintf("%d.2", build_nr)).green? &&
      toolshedr.job(sprintf("%d.3", build_nr)).green? &&
      toolshedr.job(sprintf("%d.4", build_nr)).green? &&
      toolshedr.job(sprintf("%d.5", build_nr)).green?
  )

end

# Wait max 10 minutes
attempt = 1
WaitUtil.wait_for_condition('other jobs to finish', :verbose => true, :timeout_sec => 600, :delay_sec => 15) do
  attempt += 1

  [are_builds_finished(ENV['TRAVIS_BUILD_NUMBER'] ), "Seems that jobs take way to long to finish!"]
end

exit are_we_ready_to_continue(ENV['TRAVIS_BUILD_NUMBER'] ) ? 0 : 1
