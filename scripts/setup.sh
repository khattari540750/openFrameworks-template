#!/bin/bash -e

# variables
of_version=v0.9.1
of_name=of_${of_version}_osx_release
of_url=http://openframeworks.cc/versions/${of_version}/${of_name}.zip
working_dir=`mktemp -d`
script_dir=`dirname $0`

# function
usage_exit() {
  echo "Usage: `basename $0` -f [openFrameworks zip file path]"
  exit 1
}

# parse option
while getopts f:h OPT
do
  case ${OPT} in
    f) zip_file=${OPTARG}
      ;;
    h) usage_exit
      ;;
  esac
done

echo working directory: ${working_dir}

# process
if [ -e "${zip_file}" ]; then
  echo zip file: ${zip_file}
  cp ${zip_file} ${working_dir}/${of_name}.zip
else
  curl ${of_url} -o ${working_dir}/${of_name}.zip
fi

unzip ${working_dir}/${of_name}.zip -d ${working_dir}
rsync -av ${working_dir}/${of_name}/ ${script_dir}/../openFrameworks

echo Success!

