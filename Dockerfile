FROM starrocks/dev-env:main
# Your ssh password, default is xxx.
ARG password=xxx
ARG starrockshome=/root/starrocks
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN yum -y install openssh-server && \
    ssh-keygen -A && \
    echo "root:${password}" |chpasswd && \
    sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    yum -y install libffi-devel centos-release-scl vim openssl openssl-devel tmux && \
    yum -y install \ 
      devtoolset-11-gdb \
      rh-mysql57-mysql \
      devtoolset-11-gdb-gdbserver \
      rh-git227-git \
      debuginfo-install bzip2-libs-1.0.6-13.el7.x86_64 \
      elfutils-libelf-0.176-5.el7.x86_64 \
      elfutils-libs-0.176-5.el7.x86_64 \
      glibc-2.17-325.el7_9.x86_64 libattr-2.4.46-13.el7.x86_64 \
      libcap-2.22-11.el7.x86_64 systemd-libs-219-78.el7.x86_64 \
      xz-libs-5.2.2-1.el7.x86_64 zlib-1.2.7-20.el7_9.x86_64 && \
    # If your server is not in China, you can use GitHub.
    git clone https://github.com/rui314/mold.git /root/mold && \
    # git clone https://gitee.com/mirrors/mold.git /root/mold && \
    cd /root/mold && \
    git checkout v1.4.0 && \
    make -j$(nproc) && \
    make install && \
    ln -s /usr/local/bin/mold /usr/local/bin/ld
 
ENV STARROCKS_HOME ${starrockshome}
RUN echo "export STARROCKS_GCC_HOME=/usr">>~/.bashrc && \
    echo "export STARROCKS_THIRDPARTY=/var/local/thirdparty">>~/.bashrc && \
    echo "export STARROCKS_HOME=${STARROCKS_HOME}">>~/.bashrc && \
    echo "export JAVA_HOME=/usr/java/jdk" >> ~/.bashrc && \
    echo "export DEFAULT_DIR=/var/local" >> ~/.bashrc && \
    echo "export MAVEN_HOME=/usr/share/maven" >> ~/.bashrc && \
    echo "export PATH=$PATH:/var/local/llvm/bin:$JAVA_HOME/bin" >> ~/.bashrc && \
    echo "export STARROCKS_CXX_LINKER_FLAGS=-B/usr/local/bin" >> ~/.bashrc && \
    echo "export BUILD_TYPE=DEBUG" >> ~/.bashrc && \
    echo "source /opt/rh/devtoolset-11/enable" >> ~/.bashrc && \
    echo "source /opt/rh/rh-git227/enable" >> ~/.bashrc && \
    echo "source /opt/rh/rh-mysql57/enable" >> ~/.bashrc
 
# Default ssh port is 2222, you can change it.
EXPOSE 2222
CMD ["/usr/sbin/sshd", "-D", "-p", "2222"]
