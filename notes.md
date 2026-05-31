# Target paper structure

1. Intro
2. State of the art - co podobného existuje, co to umí a jak se to liší, pak zvlášť technologie
3. Co je naším cílem a jak se to liší /inspirace, naše technologie, vlastní příspěvek, requirementy (research question), analýza implementace, implementační detaily, experimenty
4. Summary, end

# State-of-the-art notes

Primary source mined so far: Beg, O'Donoghue, Monahan — *A Short Survey on Formalising Software Requirements with Large Language Models* (ADAPT research centre, arXiv:2506.11874v1). LaTeX + .bbl in [resources/arXiv-2506.11874v1/](resources/arXiv-2506.11874v1/). Citations below are given as Author (year) followed by the survey's BibTeX key in `\cite{...}` form, so they can be pasted straight into our .bib file.

## A) Papers that use LLMs to rewrite/translate requirements into formal artefacts

Grouped by the kind of formal target.

### A.1 Natural language → formal logic / temporal logic
- **nl2spec** — Cosler, Hahn, Mendoza, Schmitt, Trippel (2023) `\cite{cosler2023nl2specinteractivelytranslatingunstructured}`. Framework using LLMs to generate formal specifications from NL with iterative user refinement to reduce ambiguity. Open-source, web UI. (Prompt-only + iterative.)
- **NL → LTL via LLMs (Learning from failures)** — Xu, Feng, Miao (2024) `\cite{10684640}`. Dynamic prompt generation + human-in-the-loop turning unstructured NL requirements into NL/LTL pairs. Up to 94.4 % accuracy on datasets of 36 and 255 000 pairs.
- **Early NL → temporal logic** — Nelken & Francez (1996) `\cite{Nelken1996}`. Pre-LLM automatic translation from NL sentences to temporal logic for formal verification (a "foundational" reference point).
- **Formal specifications from natural language** — Hahn, Schmitt, Tillman, Metzger, Siber, Finkbeiner (2022) `\cite{hahn2022formalspecificationsnaturallanguage}`. LLM-based translation into regex / FOL / LTL; reported as highly adaptable.

### A.2 Natural language → contracts / assertions for deductive verifiers
- **Symbolic NLP vs ChatGPT for JML** — Leong & Barbosa (2023) `\cite{10207159}`. Compares symbolic NLP and ChatGPT in generating Java Modeling Language contracts from NL preconditions.
- **GPT-4o for VeriFast (C, separation logic)** — Fan, Rego, Hu, Dod, Ni, Xie, DiVincenzo, Tan (2025) `\cite{fan2025evaluatingabilitylargelanguage}`. Generated specs preserve functional behaviour but frequently fail verification or contain redundancies.
- **Laurel** — Mugnier, Gonzalez, Jhala, Polikarpova, Zhou (2024) `\cite{mugnier2024laurelgeneratingdafnyassertions}`. Uses an LLM to generate Dafny helper assertions for an SMT-backed proof; >50 % of helpers correctly generated.
- **AI-assisted synthesis of verified Dafny methods (retrieval-augmented CoT)** — Misu, Lopes, Ma, Noble (2024) `\cite{10.1145/3643763}`. GPT-4 / PaLM-2 from MBPP benchmark → 153 verified Dafny solutions, retrieval-augmented CoT best.
- **AssertLLM** — Fang, Li, Li, Yan, Liu, Zhang, Xie (2024) `\cite{10691792}`. Generates SystemVerilog/hardware assertions from design specs using 3 customised LLMs; 89 % correct.
- **Specify what? (PathCrawler + EVA + LLM for ACSL)** — Granberry, Ahrendt, Johansson (2025) `\cite{Granberry2025a}`. Symbolic analysis output (PathCrawler, EVA in Frama-C) feeds prompts to produce ACSL annotations for C.
- **SpecGen** — Ma, Liu, Li, Xie, Bu (2024) `\cite{Ma2024}`. Two-phase: conversational prompting, then four mutation operators when verification fails. 279/384 programs got verifiable specs on SV-COMP & SpecGen benchmarks.
- **SpecSyn** — Mandal, Chethan, Janfaza, Mahmud, Anderson, Turek, Tithi, Muzahid (2023) `\cite{mandal2023largelanguagemodelsbased}`. Frames specification synthesis as seq2seq; +21 % accuracy vs prior tools. Fine-tuned.
- **SynVer (automated verification of LLM-synthesised C)** — Mukherjee & Delaware (2024) `\cite{mukherjee2024automatedverificationllmsynthesizedc}`. Synthesises and verifies C programs with the Verified Software Toolchain.

### A.3 Natural language → industrial/embedded requirement formats
- **Req2Spec** — Nayak, Timmapathini, Murali, Ponnalagu, Venkoparao, Post (2022) `\cite{Req2SpecPaper}`. NLP tool feeding HANFOR (BOSCH automotive requirements/test-generation platform). 71 % of 222 automotive requirements correctly formalised. **Most directly comparable to a typical RE→formal-spec pipeline.**
- **LLM safety-requirements pipeline for autonomous vehicles** — Nouri, Cabrero-Daniel, Törner, Sivencrona, Berger (2024) `\cite{10628478}`. Uses LLMs to decompose and refine safety requirements; expert evaluation + industrial trial.
- **LLMs for verifying technical system specifications against requirements** — Reinpold, Schieseck, Wagner, Gehlhoff, Fay (2024) `\cite{reinpold2024exploringllmsverifyingtechnical}`. GPT-4o & Claude 3.5 Sonnet on smart-grid / technical-system specs; F1 0.79–0.94.
- **Formal consistency checking over NL specifications** — Yan, Cheng, Chai (2015) `\cite{7092662}`. Aligns NL specs with formal targets using time extraction, IO partitioning, semantic reasoning.
- **Lightweight validation of natural language requirements** — Gervasi & Nuseibeh (2002) `\cite{10.1002/spe.430}`. Older but foundational on NL-requirements validation; the survey uses it as a NASA/ISS-style baseline / motivation reference.

### A.4 LLM + theorem prover / SMT integrations (neuro-symbolic)
- **Explanation-Refiner** — Quan, Valentino, Dennis, Freitas (2024) `\cite{quan2024verificationrefinementnaturallanguage}`. LLM + theorem prover loop validates and refines NL explanations; also gives feedback to NLI models.
- **SAT-LLM** — Fazelnia, Mirakhorli, Bagheri (2024) `\cite{10.1145/3691620.3695302}`. LLM + SMT to find conflicting requirements; F1 0.91, 80 % conflicts detected, precision 1.00.
- **Thor + "Hammers"** — Jiang, Li, Tworkowski, Czechowski, Odrzygóźdź, Miłoś, Wu, Jamnik (2022) `\cite{Jiang2022}`. Language model + theorem prover; 39 → 57 % on PISA, SOTA on MiniF2F.
- **LeanDojo / ReProver** — Yang, Swope, Gu, Chalamala, Song, Yu, Godil, Prenger, Anandkumar (2023) `\cite{Yang2023}`. Toolkit for Lean + retrieval-augmented LLM prover; benchmark of 98 734 theorems.
- **Lemur** — Wu, Barrett, Narodytska (2024) `\cite{wu2024lemurintegratinglargelanguage}`. LLM + automated reasoner with sound transition rules for program verification.
- **ESBMC-AI / self-healing software** — Tihanyi, Jain, Charalambous, Ferrag, Sun, Cordeiro (2024) `\cite{tihanyi2024newerasoftwaresecurity}`. LLM + bounded model checker for vulnerability detection/fixing.
- **Copilot + formal methods (IDE proposal)** — Granberry, Ahrendt, Johansson (2025) `\cite{Granberry2025}`. Proposes integrating Dafny, Ada/SPARK, Frama-C, KeY (with Coq/Isabelle/Lean) into Copilot-style IDE via language servers.

### A.5 Requirements coverage / domain modelling / SWOT / surveys
- **High-level → low-level requirements coverage with LLMs** — Preda, Mayr-Dorn, Mashkoor, Egyed (2024) `\cite{10.1145/3643991.3644922}`. Checks low-level reqs cover high-level reqs; 99.7 % recall on missing coverage.
- **Extracting domain models from NL requirements (industrial)** — Arora, Sabetzadeh, Briand, Zimmer (2016) `\cite{10.1145/2976767.2976769}`. Industrial case study at the requirements level.
- **Advancing RE through generative AI** — Arora, Grundy, Abdelrazek (2023) `\cite{arora2023advancingrequirementsengineeringgenerative}`. SWOT-style assessment of LLMs in RE; defines research directions.
- **NL Verification Pipeline / ANTONIO toolkit** — Casadio, Dinkar, Komendantskaya, Arnaboldi, Daggitt, Isac, Katz, Rieser, Lemon (2025) `\cite{Casadio2025}`. Proposes structured verification metrics for NLP outputs (semantic subspaces).
- **LLM-based code/requirements verification (GPT-3.5)** — Couder, Gomez, Ochoa (2024) `\cite{10500073}`. Uses LLMs to verify code against requirements and explain whether they are met.
- **VLSI design specification with LLMs (SpecLLM)** — Li, Fang, Zhang, Xie (2024) `\cite{li2024specllmexploringgenerationreview}`. LLMs to generate and review VLSI design specs.
- Systematic reviews:
  - NL → formal specification literature — Necula, Dumitriu, Greavu-Șerban (2024) `\cite{Necula2024}`.
  - Formal spec & verification of autonomous robotic systems (2008–2018) — Luckcuck, Farrell, Dennis, Dixon, Fisher (2019) `\cite{10.1145/3342355}`.
  - NLP in software development (NLPL / SNAPL) — Ernst (2017) `\cite{ernst:LIPIcs.SNAPL.2017.4}`.
  - Formal methods, academia to industry — Huisman, Gurov, Malkis (2024) `\cite{Huisman2024}`.

## B) Custom formalisms / controlled languages designed to make requirements easier to write (by humans or LLMs)

This is the side branch the user specifically asked about. Findings so far:

- **RML — Requirements Modeling Language (1986)** — Greenspan, Borgida, Mylopoulos (1986) `\cite{Greenspan1986}`. Conceptual-model based language for writing requirements with precision and consistency. Cited by the survey as a foundational entry in the area.
- **RSL — Requirements Specification Language, ReDSeeDS** — Nowakowski, Śmiałek, Ambroziewicz, Straszak (2013) `\cite{nowakowski2013requirements}`. Model-based language *and* development platform; written in constrained natural language, with automated transformation into code. Classified by the survey as "Fine-tuned / Controlled NL". Probably the closest match to what we are building.
- **Controlled Natural Language (CL) with ANLT** — Osborne & MacNish (1996) `\cite{491451}`. Primitive but pivotal: requirements written in a *limited subset of English* and translated into logical expressions in order to detect ambiguity. Often cited as origin of CNL-for-requirements.
- **ARSENAL** — Ghosh, Elenius, Li, Lincoln, Shankar, Steiner (2016) `\cite{Ghosh2016}`. Automatic requirement specification extraction from NL via a structured NL frontend; NASA Formal Methods conference.
- **Process model ↔ NL translation** — Leopold, Mendling, Polyvyanyy (2014) `\cite{6823180}`. Inverse direction (BPM → NL); relevant as it shares the structured-NL ↔ formal-model translation framing.
- **JML** is mentioned as a target (Java Modeling Language) — a formal contract language attached to Java method signatures; not a "reduced English" but worth listing as the canonical contract surface (target of `\cite{10207159}`).
- **ACSL** — ANSI/ISO C Specification Language used by Frama-C; another target contract language (target of `\cite{Granberry2025a}`).
- **NL-LTL pair datasets** — Xu, Feng, Miao (2024) `\cite{10684640}`. Implicitly relies on a *restricted* English grammar to be machine-translatable; not a named CNL but a similar idea.

**Worth searching beyond the survey** (not yet covered, but relevant SoTA on controlled/structured NL for requirements — to add manually with proper citations):
- **EARS (Easy Approach to Requirements Syntax)** — Mavin et al., Rolls-Royce; the de-facto industry CNL for requirements ("WHEN <trigger> the <system> SHALL <response>"). Very plausibly already used as input format for several LLM pipelines; we should confirm.
- **Attempto Controlled English (ACE)** — full CNL with parser producing first-order logic / OWL.
- **Boilerplate / template-based requirements** — Hull/Jackson/Dick patterns.
- **SBVR Structured English** (OMG standard) — for business-rule requirements.
- **PENG / PENG-ASP, Rabbit, CLCE, ITA Controlled English** — academic CNLs that target logic.
- **Gherkin / Cucumber "Given-When-Then"** — semi-formal behavioural syntax; widely used and could be analysed as a "controlled NL" pipeline input for LLMs.

These should be checked against recent literature (2023-2026) for LLM-era usage; the survey is biased toward "free NL → formal" pipelines and gives the CNL strand only light coverage.

## C) Other content the State of the Art chapter should cover

### C.1 Technologies / formal targets that recur in the literature
- **Verifiers / provers used as ground truth**: Dafny, VeriFast, Frama-C (ACSL), KeY, Coq, Isabelle/HOL, Lean, Ada/SPARK, SMT solvers (Z3 etc.), ESBMC, VST.
- **Specification languages**: JML, ACSL, Dafny contracts, LTL, FOL, regex, SystemVerilog assertions, OCL, TLA+ (the last two not in the survey but standard).

### C.2 Methodological taxonomy from the survey (Table 1) — useful framing for our SoTA
Categories the survey uses to classify works — we can reuse them:
1. Prompt-only (zero-shot).
2. Prompt + iterative / human-in-the-loop / Chain-of-Thought.
3. Fine-tuned LLMs.
4. Verifier-in-the-loop.
5. Neuro-symbolic (LLM + SMT / theorem prover).
6. Baseline / Manual / Controlled NL.
7. Meta-analysis / tool support.
8. IDE integration.

### C.3 Prompt-engineering techniques relevant to RE→formal pipelines
From survey §5 — worth a paragraph because our system will likely use them:
- Zero-shot reasoning — Kojima, Gu, Reid, Matsuo, Iwasawa (2022) `\cite{Kojima2022}` ("Let's think step by step").
- One-shot learning as instruction-data prospecting — Li et al. (2024) `\cite{li2024oneshotlearninginstructiondata}`.
- Limits of few-shot: zero-shot can beat few-shot — Ye & Durrett (2022) `\cite{NEURIPS2022c4025018}`.
- Self-convinced (few-shot QA) — Zhang, Cai, Zhang, Zhang, Mao, Wu (2023) `\cite{zhang2023selfconvincedpromptingfewshotquestion}`.
- Chain-of-Thought (CoT) — Wei et al. (2022) `\cite{Jason2022}`.
- Structured CoT for code — Li, Li, Li, Jin (2025) `\cite{10.1145/3690635}`.
- Automate-CoT (automatic prompt augmentation/selection) — Shum, Diao, Zhang (2023) `\cite{DBLP:conf/emnlp/ShumDZ23}`.
- PromptCoT — Yao et al. (2024) `\cite{10656469}`.
- Reprompting (Gibbs sampling) — Xu, Banburski-Fahey, Jojic (2023) `\cite{DBLP:journals/corr/abs-2305-09993}`.
- Tree-of-Thought / Graph-of-Thought topology survey — Besta et al. (2024) `\cite{Besta2024}`.
- Retrieval-Augmented Generation (RAG) — Lewis et al. (2020) `\cite{Lewis2020}`.
- Prompt-pattern catalog — White et al. (2023) `\cite{DBLP:journals/corr/abs-2302-11382}`.
- Prompt design and engineering intro — Amatriain (2024) `\cite{amatriain2024promptdesignengineeringintroduction}`.
- LoRA fine-tuning — Hu et al. (2022) `\cite{Hu2022}`.
- "Lost-in-the-middle" / positional attention bias when CoT + long contexts — Hsieh et al. (2024) `\cite{Chen2024}`.

### C.5 Open problems / gaps the SoTA leaves us
- Full contract synthesis is still much less reliable than localised assertion generation (survey §4.8).
- LLM outputs often look right but fail verification — verifier-in-loop is needed.
- Most works target English NL; little on non-English or multilingual requirements.
- Most works evaluate on synthetic / small datasets; industrial case studies are rare (BOSCH/HANFOR, NASA, smart grid, autonomous-vehicle safety are the few).
- Limited treatment of *traceability* between NL requirements and formal artefacts.
- Limited use of *controlled NL* as an intermediate representation between free NL and formal logic — possible angle for our own contribution.

### C.6 Suggested structure for our SoTA chapter
1. Motivation (why formalise requirements; safety standards).
2. Classical / pre-LLM approaches: CNL families (Attempto, ACE, EARS, PENG, RML, RSL/ReDSeeDS), grammar/template methods, symbolic NLP.
3. LLM-based approaches:
   - 3.1 NL → temporal / first-order logic.
   - 3.2 NL → deductive-verifier contracts (Dafny, JML, ACSL, VeriFast).
   - 3.3 NL → industrial RE formats (HANFOR, automotive, smart-grid).
   - 3.4 Neuro-symbolic (LLM + SMT / prover).
   - 3.5 Coverage / consistency / conflict detection.
4. Cross-cutting prompt-engineering techniques.
5. Gaps / our positioning.

## D) TODOs before writing prose
- [x] Dereference the survey's `[N]` citations — now resolved against [resources/arXiv-2506.11874v1/SAIV-ExtendedAbstract-Draft-OnGo.bbl](resources/arXiv-2506.11874v1/SAIV-ExtendedAbstract-Draft-OnGo.bbl); BibTeX keys are inline above.
- [ ] Copy the actual `@article{...}` / `@inproceedings{...}` BibTeX entries into [2019-PPFIT-ShortName-bib.bib](2019-PPFIT-ShortName-bib.bib). The .bbl only gives formatted entries — we either translate them by hand, or pull the originals from DOI/arXiv. The keys to import are listed inline in sections A–C.
- [ ] Look up EARS, Attempto/ACE, SBVR, Gherkin etc. for proper CNL coverage — not in the survey.
- [ ] Decide whether our own contribution should be framed as "controlled NL frontend for LLM-based formalisation" vs "verifier-in-the-loop pipeline" vs "neuro-symbolic" — affects which related-work strand we emphasise.
- [ ] Decide whether to mention safety standards in motivation: IEC 61508 — Bell (2006) `\cite{10.5555/1151816.1151817}`, DO-178C — Brosgol (2011) `\cite{10.1145/2070336.2070341}`, ISO 26262 — Palin, Ward, Habli, Rivett (2011) `\cite{6136916}`.
