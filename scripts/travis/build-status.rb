#!/usr/bin/env ruby
require 'travis'
require 'waitutil'


# if puts rails.job('21.1').red? exit

##
# Chech are following build completed!
# 1. test-php-min
# 2. test-php-stable
# 3. test-npm-min
# 4. test-npm-stable
##

def we_ready_to_continue(build_nr)
  toolshedr = Travis::Repository.find('mkungla/toolshedr')
  job1_status = toolshedr.job(sprintf("%d.1", build_nr)).green?
  job2_status = toolshedr.job(sprintf("%d.1", build_nr)).green?
  job3_status = toolshedr.job(sprintf("%d.1", build_nr)).green?
  job4_status = toolshedr.job(sprintf("%d.1", build_nr)).green?
  printf("Are jobs green JOB-1:%s JOB-2:%s JOB-3:%s JOB-4:%s \n", job1_status, job2_status, job3_status, job4_status)
  return [job1_status, job2_status, job3_status, job4_status].all?

end

def are_builds_finished(build_nr, attempts)
  time_since_beginning = attempts == 1 ? 1 : attempts * 15

  toolshedr = Travis::Repository.find('mkungla/toolshedr')

  job1_status = toolshedr.job(sprintf("%d.1", build_nr)).color
  job2_status = toolshedr.job(sprintf("%d.1", build_nr)).color
  job3_status = toolshedr.job(sprintf("%d.1", build_nr)).color
  job4_status = toolshedr.job(sprintf("%d.1", build_nr)).color

  printf("Checking are previous jobs done ... Waiting already for %d seconds. \n", time_since_beginning)
  printf("Job states JOB-1:%s JOB-2:%s JOB-3:%s JOB-4:%s \n", job1_status, job2_status, job3_status, job4_status)

  return we_ready_to_continue(build_nr)
end

# Wait max 10 minutes
attempt = 1
WaitUtil.wait_for_condition('other jobs to finish', :verbose => true, :timeout_sec => 600, :delay_sec => 15) do
  attempt += 1

  [are_builds_finished(ENV['TRAVIS_BUILD_NUMBER'], attempt), 'Seems that jobs take way to long to finish!']
end

if (we_ready_to_continue(ENV['TRAVIS_BUILD_NUMBER']))
  puts 'Yeah!!! All previous jobs succeeded we can continue.'
  exit 0
else
  puts 'One or more previous Jobs failed so we are not even attending to release.'
  exit 1
end
