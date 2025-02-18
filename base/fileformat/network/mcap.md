---
sidebar_position: 3
slug: /mcap
---

# MCAP 文件格式



MCAP (pronounced "em-cap") is an open source container file format for multimodal log data. It supports multiple channels of timestamped pre-serialized data, and is ideal for use in pub/sub or robotics applications.



## 概述

MCAP is a modular container file format for recording timestamped [pub/sub](https://en.wikipedia.org/wiki/Publish–subscribe_pattern) messages with arbitrary serialization formats.

MCAP files are designed to work well under various workloads, resource constraints, and durability requirements.

A [Kaitai Struct](http://kaitai.io/) description for the MCAP format is provided at [mcap.ksy](https://github.com/foxglove/mcap/blob/main/website/docs/spec/mcap.ksy).



## 名词解释

MCAP organizes its data via messages, channels, and schemas.

### Message

The unit of communication between nodes in the pub/sub system.

### Channel

A stream of messages which have the same type, or schema. Often corresponds to a connection between a publisher and a subscriber.

### Schema

A description of the structure and contents of messages on a channel, e.g. a [Protobuf Schema](https://protobuf.dev/programming-guides/proto3/) or [JSON Schema](https://json-schema.org/).



## 文件结构

A valid MCAP file is structured as follows. The Summary and Summary Offset sections are optional.

```bash
<Magic>
<Header>
<Data section>[<Summary section>][<Summary Offset section>]
<Footer>
<Magic>
```

The Data, Summary, and Summary Offset sections are structured as sequences of **records**:

```bash
[
<record type><record content length><record>
<record type><record content length><record>
...
]
```

Files not conforming to this structure are considered malformed.



### Magic

An MCAP file must begin and end with the following [magic bytes](https://en.wikipedia.org/wiki/File_format#Magic_number):

```text
0x89, M, C, A, P, 0x30, \r, \n
```



The byte following "MCAP" is the major version byte. `0x30` is the ASCII character `0`. Any changes to this specification document (i.e. adding fields to records, introducing new records) will be binary backward-compatible within the major version.

### Header

The first record after the leading magic bytes is the [Header](https://mcap.dev/spec#header-op0x01) record.

```text
<0x01><record content length><record>
```



### Footer

The last record before the trailing magic bytes is the [Footer](https://mcap.dev/spec#footer-op0x02) record.

```text
<0x02><record content length><record>
```



### Data Section

The data section contains records with message data, attachments, and supporting records.

The following records are allowed to appear in the data section:

- [Schema](https://mcap.dev/spec#schema-op0x03)
- [Channel](https://mcap.dev/spec#channel-op0x04)
- [Message](https://mcap.dev/spec#message-op0x05)
- [Attachment](https://mcap.dev/spec#attachment-op0x09)
- [Chunk](https://mcap.dev/spec#chunk-op0x06)
- [Message Index](https://mcap.dev/spec#message-index-op0x07)
- [Metadata](https://mcap.dev/spec#metadata-op0x0C)
- [Data End](https://mcap.dev/spec#data-end-op0x0F)

The last record in the data section MUST be the [Data End](https://mcap.dev/spec#data-end-op0x0F) record.

#### Use of chunk records

MCAP files can have Schema, Channel, and Message records written directly to the data section, or they can be written into Chunk records to facilitate indexing and compression. For MCAPs that include [Chunk Index](https://mcap.dev/spec#chunk-index-op0x08) records in the summary section, all Message records should be written into Chunk records.

> Why? The presence of Chunk Index records in the summary section indicates to readers that the MCAP is indexed, and they can use those records to look up messages by log time or topic. However, Message records outside of chunks cannot be indexed, and may not be found by readers using the index.

### Summary Section

The optional summary section contains records for fast lookup of file information or other data section records.

The following records are allowed to appear in the summary section:

- [Schema](https://mcap.dev/spec#schema-op0x03)
- [Channel](https://mcap.dev/spec#channel-op0x04)
- [Chunk Index](https://mcap.dev/spec#chunk-index-op0x08)
- [Attachment Index](https://mcap.dev/spec#attachment-index-op0x0A)
- [Metadata Index](https://mcap.dev/spec#metadata-index-op0x0D)
- [Statistics](https://mcap.dev/spec#statistics-op0x0B)

All records in the summary section MUST be grouped by opcode.

> Why? Grouping Summary records by record opcode enables more efficient indexing of the summary in the Summary Offset section.

Channel records in the summary are duplicates of Channel records throughout the Data section.

Schema records in the summary are duplicates of Schema records throughout the Data section.

### Summary Offset Section

The optional summary offset section contains [Summary Offset](https://mcap.dev/spec#summary-offset-op0x0E) records for fast lookup of summary section records.

The summary offset section aids random access reading.



## Records

MCAP files may contain a variety of records. Records are identified by a single-byte **opcode**. Record opcodes in the range 0x01-0x7F are reserved for future MCAP format usage. 0x80-0xFF are reserved for application extensions and user proposals. 0x00 is not a valid opcode.

All MCAP records are serialized as follows:

```text
<record type><record content length><record content>
```



Record type is a single byte opcode, and record content length is a uint64 value.

Records may be extended by adding new fields at the end of existing fields. Readers should ignore any unknown fields.

> The Footer and Message records will not be extended, since their formats do not allow for backward-compatible size changes.

Each record definition below contains a `Type` column. See the [Serialization](https://mcap.dev/spec#serialization) section on how to serialize each type.



## 相关链接

- [MCAP 官网](https://mcap.dev)
