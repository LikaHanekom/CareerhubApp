// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_application_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetJobApplicationIsarCollection on Isar {
  IsarCollection<JobApplicationIsar> get jobApplicationIsars =>
      this.collection();
}

const JobApplicationIsarSchema = CollectionSchema(
  name: r'JobApplicationIsar',
  id: -596041354592425319,
  properties: {
    r'applicationId': PropertySchema(
      id: 0,
      name: r'applicationId',
      type: IsarType.string,
    ),
    r'company': PropertySchema(id: 1, name: r'company', type: IsarType.string),
    r'dateApplied': PropertySchema(
      id: 2,
      name: r'dateApplied',
      type: IsarType.dateTime,
    ),
    r'jobTitle': PropertySchema(
      id: 3,
      name: r'jobTitle',
      type: IsarType.string,
    ),
    r'status': PropertySchema(id: 4, name: r'status', type: IsarType.string),
  },

  estimateSize: _jobApplicationIsarEstimateSize,
  serialize: _jobApplicationIsarSerialize,
  deserialize: _jobApplicationIsarDeserialize,
  deserializeProp: _jobApplicationIsarDeserializeProp,
  idName: r'id',
  indexes: {
    r'applicationId': IndexSchema(
      id: -6637474116175318442,
      name: r'applicationId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'applicationId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _jobApplicationIsarGetId,
  getLinks: _jobApplicationIsarGetLinks,
  attach: _jobApplicationIsarAttach,
  version: '3.3.2',
);

int _jobApplicationIsarEstimateSize(
  JobApplicationIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.applicationId.length * 3;
  bytesCount += 3 + object.company.length * 3;
  bytesCount += 3 + object.jobTitle.length * 3;
  bytesCount += 3 + object.status.length * 3;
  return bytesCount;
}

void _jobApplicationIsarSerialize(
  JobApplicationIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.applicationId);
  writer.writeString(offsets[1], object.company);
  writer.writeDateTime(offsets[2], object.dateApplied);
  writer.writeString(offsets[3], object.jobTitle);
  writer.writeString(offsets[4], object.status);
}

JobApplicationIsar _jobApplicationIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = JobApplicationIsar();
  object.applicationId = reader.readString(offsets[0]);
  object.company = reader.readString(offsets[1]);
  object.dateApplied = reader.readDateTime(offsets[2]);
  object.id = id;
  object.jobTitle = reader.readString(offsets[3]);
  object.status = reader.readString(offsets[4]);
  return object;
}

P _jobApplicationIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _jobApplicationIsarGetId(JobApplicationIsar object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _jobApplicationIsarGetLinks(
  JobApplicationIsar object,
) {
  return [];
}

void _jobApplicationIsarAttach(
  IsarCollection<dynamic> col,
  Id id,
  JobApplicationIsar object,
) {
  object.id = id;
}

extension JobApplicationIsarByIndex on IsarCollection<JobApplicationIsar> {
  Future<JobApplicationIsar?> getByApplicationId(String applicationId) {
    return getByIndex(r'applicationId', [applicationId]);
  }

  JobApplicationIsar? getByApplicationIdSync(String applicationId) {
    return getByIndexSync(r'applicationId', [applicationId]);
  }

  Future<bool> deleteByApplicationId(String applicationId) {
    return deleteByIndex(r'applicationId', [applicationId]);
  }

  bool deleteByApplicationIdSync(String applicationId) {
    return deleteByIndexSync(r'applicationId', [applicationId]);
  }

  Future<List<JobApplicationIsar?>> getAllByApplicationId(
    List<String> applicationIdValues,
  ) {
    final values = applicationIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'applicationId', values);
  }

  List<JobApplicationIsar?> getAllByApplicationIdSync(
    List<String> applicationIdValues,
  ) {
    final values = applicationIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'applicationId', values);
  }

  Future<int> deleteAllByApplicationId(List<String> applicationIdValues) {
    final values = applicationIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'applicationId', values);
  }

  int deleteAllByApplicationIdSync(List<String> applicationIdValues) {
    final values = applicationIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'applicationId', values);
  }

  Future<Id> putByApplicationId(JobApplicationIsar object) {
    return putByIndex(r'applicationId', object);
  }

  Id putByApplicationIdSync(
    JobApplicationIsar object, {
    bool saveLinks = true,
  }) {
    return putByIndexSync(r'applicationId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByApplicationId(List<JobApplicationIsar> objects) {
    return putAllByIndex(r'applicationId', objects);
  }

  List<Id> putAllByApplicationIdSync(
    List<JobApplicationIsar> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'applicationId', objects, saveLinks: saveLinks);
  }
}

extension JobApplicationIsarQueryWhereSort
    on QueryBuilder<JobApplicationIsar, JobApplicationIsar, QWhere> {
  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension JobApplicationIsarQueryWhere
    on QueryBuilder<JobApplicationIsar, JobApplicationIsar, QWhereClause> {
  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterWhereClause>
  idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterWhereClause>
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterWhereClause>
  applicationIdEqualTo(String applicationId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'applicationId',
          value: [applicationId],
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterWhereClause>
  applicationIdNotEqualTo(String applicationId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'applicationId',
                lower: [],
                upper: [applicationId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'applicationId',
                lower: [applicationId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'applicationId',
                lower: [applicationId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'applicationId',
                lower: [],
                upper: [applicationId],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension JobApplicationIsarQueryFilter
    on QueryBuilder<JobApplicationIsar, JobApplicationIsar, QFilterCondition> {
  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  applicationIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'applicationId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  applicationIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'applicationId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  applicationIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'applicationId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  applicationIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'applicationId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  applicationIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'applicationId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  applicationIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'applicationId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  applicationIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'applicationId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  applicationIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'applicationId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  applicationIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'applicationId', value: ''),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  applicationIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'applicationId', value: ''),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  companyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'company',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  companyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'company',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  companyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'company',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  companyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'company',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  companyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'company',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  companyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'company',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  companyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'company',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  companyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'company',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  companyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'company', value: ''),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  companyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'company', value: ''),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  dateAppliedEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'dateApplied', value: value),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  dateAppliedGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'dateApplied',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  dateAppliedLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'dateApplied',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  dateAppliedBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'dateApplied',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  jobTitleEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'jobTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  jobTitleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'jobTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  jobTitleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'jobTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  jobTitleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'jobTitle',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  jobTitleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'jobTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  jobTitleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'jobTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  jobTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'jobTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  jobTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'jobTitle',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  jobTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'jobTitle', value: ''),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  jobTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'jobTitle', value: ''),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  statusEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'status',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  statusStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  statusEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'status',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterFilterCondition>
  statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'status', value: ''),
      );
    });
  }
}

extension JobApplicationIsarQueryObject
    on QueryBuilder<JobApplicationIsar, JobApplicationIsar, QFilterCondition> {}

extension JobApplicationIsarQueryLinks
    on QueryBuilder<JobApplicationIsar, JobApplicationIsar, QFilterCondition> {}

extension JobApplicationIsarQuerySortBy
    on QueryBuilder<JobApplicationIsar, JobApplicationIsar, QSortBy> {
  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterSortBy>
  sortByApplicationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicationId', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterSortBy>
  sortByApplicationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicationId', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterSortBy>
  sortByCompany() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'company', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterSortBy>
  sortByCompanyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'company', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterSortBy>
  sortByDateApplied() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateApplied', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterSortBy>
  sortByDateAppliedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateApplied', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterSortBy>
  sortByJobTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobTitle', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterSortBy>
  sortByJobTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobTitle', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterSortBy>
  sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterSortBy>
  sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension JobApplicationIsarQuerySortThenBy
    on QueryBuilder<JobApplicationIsar, JobApplicationIsar, QSortThenBy> {
  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterSortBy>
  thenByApplicationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicationId', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterSortBy>
  thenByApplicationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicationId', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterSortBy>
  thenByCompany() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'company', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterSortBy>
  thenByCompanyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'company', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterSortBy>
  thenByDateApplied() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateApplied', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterSortBy>
  thenByDateAppliedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateApplied', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterSortBy>
  thenByJobTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobTitle', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterSortBy>
  thenByJobTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobTitle', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterSortBy>
  thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QAfterSortBy>
  thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension JobApplicationIsarQueryWhereDistinct
    on QueryBuilder<JobApplicationIsar, JobApplicationIsar, QDistinct> {
  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QDistinct>
  distinctByApplicationId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'applicationId',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QDistinct>
  distinctByCompany({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'company', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QDistinct>
  distinctByDateApplied() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateApplied');
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QDistinct>
  distinctByJobTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'jobTitle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationIsar, JobApplicationIsar, QDistinct>
  distinctByStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }
}

extension JobApplicationIsarQueryProperty
    on QueryBuilder<JobApplicationIsar, JobApplicationIsar, QQueryProperty> {
  QueryBuilder<JobApplicationIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<JobApplicationIsar, String, QQueryOperations>
  applicationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'applicationId');
    });
  }

  QueryBuilder<JobApplicationIsar, String, QQueryOperations> companyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'company');
    });
  }

  QueryBuilder<JobApplicationIsar, DateTime, QQueryOperations>
  dateAppliedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateApplied');
    });
  }

  QueryBuilder<JobApplicationIsar, String, QQueryOperations>
  jobTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'jobTitle');
    });
  }

  QueryBuilder<JobApplicationIsar, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }
}
