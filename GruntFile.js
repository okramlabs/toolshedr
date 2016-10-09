module.exports = function (grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    
    browserify: {
      devel: {
        options: {
          transform: [['babelify', {
            presets: ["es2015"],
            plugins: [
              ["babel-plugin-transform-builtin-extend", {
                globals: ["Error", "Array"]
              }]
            ]
          }]]
        },
        files: {
          './devel/js/toolshedr.js': ['./src/app/js/index.js']
        }
      },
      dist: {
        options: {
          transform: [['babelify', {presets: ["es2015"]}]]
        },
        src: './src/app/js/index.js',
        dest: './dist/js/toolshedr.js'
      }
    },
    jshint: {
      options: {
        force: true,
        jshintrc: '.jshintrc',
        reporter: require('jshint-stylish')
      },
      devel: {
        src: ['./src/app/js/**/*.js'],
      },
    },
    compass: {
      devel: {
        options: {
          sassDir: './src/app/scss',
          cssDir: './devel/css',
          cacheDir: './tmp/.sass-cache'
        }
      },
      dist: {
        options: {
          cssDir: './dist/css',
          sassDir: './src/app/scss',
          sourcemap: true,
          outputStyle: 'compressed',
          environment: 'production'
        }
      }
    },
    uglify: {
      options: {
        banner: '/*! \n' +
        ' * Package: <%= pkg.name %> \n' +
        ' * Version: <%= pkg.version %>\n' +
        ' * Released: <%= grunt.template.today("dd mmm yyyy") %> \n' +
        ' * License: MIT \n' +
        ' * Homepage: <%= pkg.homepage %> \n' +
        '*/\n'
      },
      dist: {
        files: {
          'dist/js/toolshedr.min.js': 'dist/js/toolshedr.js'
        }
      }
    }
    ,
    watch: {
      css: {
        files: ['./src/app/scss/**/*.scss'],
        tasks: ['compass:devel'],
        options: {
          livereload: true,
        }
        ,
      }
      ,
      scripts: {
        files: ['./src/app/js/**/*.js'],
        tasks: ['jshint:devel', 'browserify:devel'],
        options: {
          livereload: true,
        }
        ,
      }
    }
    ,
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
  })
  ;

  grunt.event.on('watch', function (action, filepath) {
    grunt.config('jshint.all.src', filepath);
  });

  grunt.loadNpmTasks('grunt-contrib-connect');
  grunt.loadNpmTasks('grunt-contrib-compass');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-browserify');
  grunt.loadNpmTasks('grunt-contrib-uglify');

  grunt.registerTask('default', ['devel']);

  grunt.registerTask('devel', ['connect', 'watch']);
  grunt.registerTask('release', ["browserify:dist", "compass:dist", "uglify:dist"]);
};
