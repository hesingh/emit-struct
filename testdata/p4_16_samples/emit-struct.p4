#include <v1model.p4>

struct row_t {
    bit<1> valid;
    bit<7> port;
};

struct local_metadata_t {
    bit<8> x;
};

struct parsed_packet_t {
    row_t row;
};

parser parse(packet_in pk, out parsed_packet_t h, inout local_metadata_t local_metadata,
             inout standard_metadata_t standard_metadata) {
    state start {
	transition accept;
    }
}

control ingress(inout parsed_packet_t h, inout local_metadata_t local_metadata,
                inout standard_metadata_t standard_metadata) {
    apply {
        clone3(CloneType.I2E, 0, h);
    }
}

control egress(inout parsed_packet_t hdr, inout local_metadata_t local_metadata,
               inout standard_metadata_t standard_metadata) {
    apply { }
}

control deparser(packet_out b, in parsed_packet_t h) {
    apply {
        b.emit(h.row);
    }
}

control verify_checksum(inout parsed_packet_t hdr,
inout local_metadata_t local_metadata) {
    apply { }
}

control compute_checksum(inout parsed_packet_t hdr,
                         inout local_metadata_t local_metadata) {
    apply { }
}

V1Switch(parse(), verify_checksum(), ingress(), egress(),
compute_checksum(), deparser()) main;

