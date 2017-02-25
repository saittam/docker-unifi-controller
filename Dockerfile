FROM debian:stable

RUN \
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 06E85760C0A52C50 && \
	echo "deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti" > /etc/apt/sources.list.d/unifi.list && \
	apt-get update && \
	apt-get install -y unifi

ENV \
	BASEDIR=/usr/lib/unifi \
	DATADIR=/var/lib/unifi \
	LOGDIR=/var/log/unifi \
	RUNDIR=/var/run/unifi

RUN \
	ln -s "${DATADIR}" "${BASEDIR}/data" && \
	ln -s "${LOGDIR}" "${BASEDIR}/log" && \
	ln -s "${RUNDIR}" "${BASEDIR}/run"

COPY unifi.sh /usr/local/bin/unifi.sh

VOLUME [ "${DATADIR}", "${LOGDIR}", "${RUNDIR}" ]

ENTRYPOINT [ "/bin/bash", "/usr/local/bin/unifi.sh" ]
