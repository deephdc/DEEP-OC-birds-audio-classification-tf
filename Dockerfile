# As this is a derived service from the audio classification model
# so we can resuse the original audio classification image.

# Options: cpu, gpu, cpu-test, gpu-test
ARG tag=cpu

# Base image, e.g. tensorflow/tensorflow:1.12.0-py3
FROM deephdc/deep-oc-audio-classification-tf:${tag}

# Add container's metadata to appear along the models metadata
ENV CONTAINER_MAINTAINER "Ignacio Heredia <iheredia@ifca.unican.es>"
ENV CONTAINER_VERSION "0.1"
ENV CONTAINER_DESCRIPTION "DEEP as a Service Container: Birds Audio Classification"

# Download network weights
ENV SWIFT_CONTAINER https://cephrgw01.ifca.es:8080/swift/v1/birds-tf/
ENV MODEL_TAR birds-audio-xenocanto.tar.xz

RUN rm -rf audio-classification-tf/models/audioset

RUN curl --insecure -o ./audio-classification-tf/models/${MODEL_TAR} \
    ${SWIFT_CONTAINER}${MODEL_TAR}

RUN cd audio-classification-tf/models && \
    tar -xf ${MODEL_TAR} &&\
    rm ${MODEL_TAR}
