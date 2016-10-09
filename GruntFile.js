module.exports = function (grunt) {
  grunt.initConfig({
    browserify: {
      dev: {
        options: {
          transform: [['babelify', { presets: ["es2015"] }]]
        },
        files: {
          './devel/js/toolshedr.js': ['./src/app/js/index.js']
        }
      }
    },
    jshint: {
      options: {
        jshintrc: '.jshintrc'
      },
      all: {
        src: ['./src/app/js/**/*.js'],
      },
    },
    compass: {
      dev: {
        options: {
          sassDir: './src/app/scss',
          cssDir: './devel/css'
        }
      }
    },
    watch: {
      css: {
        files: ['./src/app/scss/**/*.scss'],
        tasks: ['compass'],
        options: {
          livereload: true,
        },
      },
      scripts: {
        files: ['./src/app/js/**/*.js'],
        tasks: ['jshint', 'browserify'],
        options: {
          livereload: true,
        },
      }
    },
    connect: {
      server: {
        options: {
          hostname: 'localhost',
          port: 9000,
          base: 'devel',
          livereload: true
        }
      }
    }
  });

  grunt.event.on('watch', function(action, filepath) {
    grunt.config('jshint.all.src', filepath);
  });
  
  grunt.loadNpmTasks('grunt-contrib-connect');
  grunt.loadNpmTasks('grunt-contrib-compass');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-browserify');
  
  grunt.registerTask('default', ['connect', 'watch', 'compass']);
  grunt.registerTask('build', ["browserify"]);
};
