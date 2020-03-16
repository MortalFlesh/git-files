#load ".fake/build.fsx/intellisense.fsx"
open Fake.Core
open Fake.DotNet
open Fake.IO
open Fake.IO.FileSystemOperators
open Fake.IO.Globbing.Operators
open Fake.Core.TargetOperators
open Fake.Tools.Git

open System.IO

type ToolDir =
    /// Global tool dir must be in PATH - ${PATH}:/root/.dotnet/tools
    | Global
    /// Just a dir name, the location will be used as: ./{LocalDirName}
    | Local of string

// ========================================================================================================
// === F# / Helper build ===================================================================== 2020-02-27 =
// --------------------------------------------------------------------------------------------------------
// Options:
// --------------------------------------------------------------------------------------------------------
// Table of contents:
//      1. Information about project, configuration
//      2. Utilities, DotnetCore functions
//      3. FAKE targets
//      4. FAKE targets hierarchy
// ========================================================================================================

// --------------------------------------------------------------------------------------------------------
// 1. Information about the project to be used at NuGet and in AssemblyInfo files and other FAKE configuration
// --------------------------------------------------------------------------------------------------------

let project = "F# Helper FAKE"
let summary = "Generic Helpers"

// --------------------------------------------------------------------------------------------------------
// 2. Utilities, DotnetCore functions, etc.
// --------------------------------------------------------------------------------------------------------

[<AutoOpen>]
module private Utils =
    let tee f a =
        f a
        a

    let skipOn option action p =
        if p.Context.Arguments |> Seq.contains option
        then Trace.tracefn "Skipped ..."
        else action p

module private DotnetCore =
    let run cmd workingDir =
        let options =
            DotNet.Options.withWorkingDirectory workingDir
            >> DotNet.Options.withRedirectOutput true

        DotNet.exec options cmd ""

    let runOrFail cmd workingDir =
        run cmd workingDir
        |> tee (fun result ->
            if result.ExitCode <> 0 then failwithf "'dotnet %s' failed in %s" cmd workingDir
        )
        |> ignore

    let runInRoot cmd = run cmd "."
    let runInRootOrFail cmd = runOrFail cmd "."

    let installOrUpdateTool toolDir tool =
        let toolCommand action =
            match toolDir with
            | Global -> sprintf "tool %s --global %s" action tool
            | Local dir -> sprintf "tool %s --tool-path ./%s %s" action dir tool

        match runInRoot (toolCommand "install") with
        | { ExitCode = code } when code <> 0 -> runInRootOrFail (toolCommand "update")
        | _ -> ()

module private Process =
    let execute command args (dir: string) =
        let cmd =
            sprintf "%s/%s"
                (dir.TrimEnd('/'))
                command

        let processInfo = System.Diagnostics.ProcessStartInfo(cmd)
        processInfo.RedirectStandardOutput <- true
        processInfo.RedirectStandardError <- true
        processInfo.UseShellExecute <- false
        processInfo.CreateNoWindow <- true
        processInfo.Arguments <- args |> String.concat " "

        use proc =
            new System.Diagnostics.Process(
                StartInfo = processInfo
            )
        if proc.Start() |> not then failwith "Process was not started."
        proc.WaitForExit()

        if proc.ExitCode <> 0 then failwithf "Command '%s' failed in %s." command dir
        (proc.StandardOutput.ReadToEnd(), proc.StandardError.ReadToEnd())

// --------------------------------------------------------------------------------------------------------
// 3. Targets for FAKE
// --------------------------------------------------------------------------------------------------------

Target.create "Help" (fun _ ->
    [
        "BuildsInfo of Path<string>"
    ]
    |> List.iter (Trace.tracefn " - %s")
)

Target.create "BuildsInfo" (fun p ->
    match p.Context.Arguments |> Seq.tryHead with
    | Some path ->
        match !! (sprintf "%s/*/build.fsx" (path.TrimEnd '/')) |> Seq.toList with
        | [] -> Trace.tracefn "There are no build.fsx files."
        | filePaths ->
            filePaths
            |> List.choose (fun path ->
                path
                |> File.ReadAllLines
                |> List.ofArray
                |> List.filter (fun line -> line.Contains "// === F#")
                |> List.tryHead
                |> Option.map (fun line -> (path, line))
            )
            |> List.map (fun (path, line) ->
                let version =
                    match line.Replace("=", "").TrimEnd(' ').Split(' ') |> List.ofArray |> List.rev with
                    | version :: _ when version.Contains "-" -> path, Some version
                    | _ -> path, None
                path, line.Replace("=", "").Replace("/", "").Trim(' '), version
            )
            |> List.sortByDescending (fun (_, title, version) -> (version, title))
            |> List.iter (function
                | path, title, _ -> Trace.tracefn " - file %A has %A" path title
            )
    | _ ->
        failwith "Set path you want to look for build.fsx."
)

// --------------------------------------------------------------------------------------------------------
// 4. FAKE targets hierarchy
// --------------------------------------------------------------------------------------------------------

Target.runOrDefaultWithArguments "Help"
